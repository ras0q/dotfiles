#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env --allow-run --allow-net

import { resolve } from "@std/path";
import { parseArgs } from "@std/cli";
import $ from "@david/dax";
import { cloneDotfiles, downloadFonts, infoLogger } from "./common.ts";

$.setInfoLogger(infoLogger);

const flags: {
  "nonroot"?: boolean;
  "verbose"?: boolean;
  "download-fonts"?: boolean;
} = parseArgs(Deno.args);
!flags.nonroot && await $`sudo echo "Hello sudoer!"`;
flags.verbose && $.setPrintCommand(true);

const home = Deno.env.get("HOME")!;
const dotfilesDir = resolve(home, "ghq/github.com/ras0q/dotfiles-v2");
const isLinux = Deno.build.os === "linux";
const isWSL2 = isLinux && Deno.env.get("WSL_DISTRO_NAME") !== undefined;
const isMacOS = Deno.build.os === "darwin";

await $.logGroup("Cloning dotfiles", cloneDotfiles);

await $.logGroup("Creating symlinks", async () => {
  const symlinks: string[][] = [
    [`${home}/.bash_profile`, "./common/.bash_profile"],
    [`${home}/.bashrc`, "./common/.bashrc"],
    [`${home}/.config/aquaproj-aqua`, "./common/aquaproj-aqua"],
    [`${home}/.config/fish`, "./common/fish"],
    [`${home}/.config/helix`, "./common/helix"],
    [`${home}/.config/nvim`, "./common/nvim"],
    [`${home}/.config/starship.toml`, "./common/starship.toml"],
    [`${home}/.gitconfig`, "./common/.gitconfig"],
    [`${home}/.gittemplate.txt`, "./common/.gittemplate.txt"],
    [`${home}/.rye/config.toml`, "./common/rye/config.toml"],
    // WSL2 only
    ...isWSL2
      ? [
        [
          `${home}/.vscode-server/extensions/extensions.json`,
          "./common/vscode/extensions.json",
        ],
        [
          `${home}/.vscode-server/data/Machine/settings.json`,
          "./common/vscode/settings.json",
        ],
        ["/etc/wsl.conf", "./wsl/wsl.conf"],
      ]
      : [],
    // MacOS only
    ...isMacOS
      ? [
        [`${home}/.Brewfile`, "./mac/.Brewfile"],
        [`${home}/.Brewfile.lock.json`, "./mac/.Brewfile.lock.json"],
        [`${home}/.config/skhd`, "./mac/skhd"],
        [`${home}/.config/yabai`, "./mac/yabai"],
        [`${home}/.gitconfig.mac`, "./mac/.gitconfig.mac"],
        [`${home}/.warp`, "./mac/warp"],
      ]
      : [],
  ];
  await Promise.all(
    symlinks.map(async ([link, target]) => {
      const linkPath = resolve(link);
      const targetPath = resolve(dotfilesDir, target);
      if (linkPath.startsWith(home)) {
        await $`rm -rf ${linkPath}`;
        await $`ln -s ${targetPath} ${linkPath}`;
        $.log(`Created symlink: ${linkPath} -> ${targetPath}`);
      } else if (!flags["nonroot"]) {
        await $`sudo rm -rf ${linkPath}`;
        await $`sudo ln -s ${targetPath} ${linkPath}`;
        $.log(`Created symlink (with sudo): ${linkPath} -> ${targetPath}`);
      } else {
        $.log(`Skipped creating symlink: ${linkPath} -> ${targetPath}`);
      }
    }),
  );
});

flags["download-fonts"] && await $.logGroup("Downloading fonts", downloadFonts);

if (isLinux && !flags["nonroot"]) {
  await $.logGroup("Installing up apt packages", async () => {
    await $`sudo apt-get update`;
    const ppas = [
      "ppa:git-core/ppa",
      "ppa:fish-shell/release-3",
    ];
    for (const ppa of ppas) {
      await $`sudo add-apt-repository -y ${ppa}`;
    }
    await $`sudo apt-get update`;
    await $`sudo apt-get upgrade -y`;

    const packages = [
      "curl",
      "ca-certificates",
      "git",
      "fish",
      "make",
      "gcc",
      "socat", // for 1Password SSH
    ];
    await $`sudo apt-get install -y ${packages}`;
    $.log(`Installed apt packages: ${packages}`);
  });

  // Ref: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
  await $.logGroup("Setting up Docker and Docker Compose", async () => {
    const gpgPath = "/etc/apt/keyrings/docker.asc";
    const gpgLink = "https://download.docker.com/linux/ubuntu/gpg";
    await $`sudo rm ${gpgPath}`;
    await $`install -m 0755 -d /etc/apt/keyrings`;
    await $`sudo tee ${gpgPath}`
      .stdin($.request(gpgLink))
      .stdout("null");
    await $`sudo chmod a+r ${gpgPath}`;
    $.log("Added Docker's GPG key");

    const arch = (await $`dpkg --print-architecture`.text()).trim();
    const codename = (await $`lsb_release -cs`.text()).trim();
    const installLink = "https://download.docker.com/linux/ubuntu";
    await $`sudo tee /etc/apt/sources.list.d/docker2.list`
      .stdinText(
        `deb [arch=${arch} signed-by=${gpgPath}] ${installLink} ${codename} stable`,
      )
      .stdout("null");
    await $`sudo apt-get update`;
    $.log("Added Docker's apt repository");

    const dockerPackages = [
      "docker-ce",
      "docker-ce-cli",
      "containerd.io",
      "docker-buildx-plugin",
      "docker-compose-plugin",
    ];
    await $`sudo apt-get install -y ${dockerPackages}`;
    $.log(`Installed Docker's apt packages: ${dockerPackages.join(", ")}`);
  });
}

if (isMacOS && !flags["nonroot"]) {
  await $.logGroup("Disabling .DS_Store", async () => {
    await $`defaults write com.apple.desktopservices DSDontWriteNetworkStores True`
  })

  await $.logGroup("Installing up Homebrew", async () => {
    if (await $.commandExists("brew")) {
      $.log("Skipped Homebrew installation");
      return;
    }

    await $`bash`.stdin(
      $.request(
        "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh",
      ),
    );
    $.log("Installed Homebrew");
  });

  await $.logGroup("Installing Homebrew packages", async () => {
    await $`brew upgrade`;
    await $`brew doctor`;
    await $`brew bundle --global --force`;
    await $`brew bundle cleanup --global --force`;
    $.log("Installed Homebrew packages (See ~/.Brewfile)");
  });
}

await $.logGroup("Installing rustup", async () => {
  if (await $.commandExists("rustup")) {
    $.log("Skipped rustup installation");
    return;
  }

  await $`bash -s -- -y --no-modify-path`.stdin(
    $.request("https://sh.rustup.rs"),
  );
  $.log("Installed rustup");
});

await $.logGroup("Installing aquaproj", async () => {
  if (await $.commandExists("aqua")) {
    $.log("Skipped aqua installation");
    return;
  }

  await $`bash`.stdin($.request(
    "https://raw.githubusercontent.com/aquaproj/aqua-installer/main/aqua-installer",
  ));
});

await $.logGroup("Installing aquaproj packages", async () => {
  await $`${home}/.local/share/aquaproj-aqua/bin/aqua install --all`;
  $.log("Installed aquaproj packages");
});

$.logGroup("Set up complete🎉🎉🎉", () => {
  $.log("Next steps");
  const nextSteps = [
    "Install fonts (from ./dist/fonts)",
    ...isWSL2 ? ["set -U NPIPERELAY_PATH {{ path to npiperelay }}"] : [],
  ];
  for (const step of nextSteps) {
    $.log(`- [ ] ${step}`);
  }
});
