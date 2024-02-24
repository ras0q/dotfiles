#!/usr/bin/env -S deno run --allow-read --allow-write --allow-env --allow-run --allow-net

import { exists } from "https://deno.land/std@0.217.0/fs/exists.ts";
import { resolve } from "https://deno.land/std@0.217.0/path/mod.ts";
import { parseArgs } from "https://deno.land/std@0.217.0/cli/parse_args.ts";
import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

$.setPrintCommand(true);

const flags: {
  "dotfiles-dir"?: string;
  "nonroot"?: boolean;
} = parseArgs(Deno.args);

!flags["nonroot"] && (await $`sudo echo "Hello sudoer!"`);

const home = Deno.env.get("HOME")!;
const dirname = import.meta.dirname || Deno.exit(1);
const config = {
  symlinks: {
    [`${home}/.bash_profile`]: "../common/config/.bash_profile",
    [`${home}/.bashrc`]: "../common/config/.bashrc",
    [`${home}/.config/aquaproj-aqua`]: "../common/config/aquaproj-aqua",
    [`${home}/.config/fish`]: "../common/config/fish",
    [`${home}/.config/nvim`]: "../common/config/nvim",
    [`${home}/.config/starship.toml`]: "../common/config/starship.toml",
    [`${home}/.gitconfig`]: "../common/config/.gitconfig",
    [`${home}/.rye/config.toml`]: "../common/config/rye/config.toml",
    // // WSL2 only
    // ...(Deno.env.get("WSL_DISTRO_NAME")
    //   ? { "/etc/wsl.conf": "./config/.wsl.conf" }
    //   : {}),

    // MacOS only
    ...(Deno.build.os === "darwin")
      ? {
        [`${home}/.Brewfile`]: "../mac/config/.Brewfile",
        [`${home}/.Brewfile.lock.json`]: "../mac/config/.Brewfile.lock.json",
        [`${home}/.gitconfig.mac`]: "../mac/config/.gitconfig.mac",
      }
      : {},
  },
  fonts: {
    links: [
      // 源ノ角ゴシック
      "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf",
      // 源ノ角ゴシック Code
      "https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf",
      // Source Code Pro (Nerd Font)
      "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFontMono-Regular.ttf",
    ],
    dist: "./dist/fonts",
  },
  apt: {
    packages: [
      "curl",
      "ca-certificates",
      "git",
      "fish",
      "make",
      "gcc",
      "socat", // for 1Password SSH
    ],
    docker: {
      gpgLink: "https://download.docker.com/linux/ubuntu/gpg",
      gpgPath: "/etc/apt/keyrings/docker.asc",
      installLink: "https://download.docker.com/linux/ubuntu",
      packages: [
        "docker-ce",
        "docker-ce-cli",
        "containerd.io",
        "docker-buildx-plugin",
        "docker-compose-plugin",
      ],
    },
  },
  brew: {
    installLink:
      "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh",
  },
  rust: {
    installLink: "https://sh.rustup.rs",
  },
  aquaproj: {
    installLink:
      "https://raw.githubusercontent.com/aquaproj/aqua-installer/main/aqua-installer",
  },
  nextSteps: [
    "Install fonts (from ./dist/fonts)"
  ]
};

$.logStep("Cloning dotfiles");
await $.logGroup(async () => {
  const dotfiles = "https://github.com/ras0q/dotfiles-v2.git";
  const dotfilesDir = flags["dotfiles-dir"]
    ? resolve(dirname, flags["dotfiles-dir"])
    : resolve(home, "ghq/github.com/ras0q/dotfiles-v2");
  if (await exists(dotfilesDir)) {
    $.logStep("Skipped dotfiles clone");
  } else {
    await $`git clone ${dotfiles} ${dotfilesDir} --depth 1`;
    $.logStep(`Cloned ${dotfilesDir}`);
  }
});

$.logStep("Creating symlinks");
await $.logGroup(async () => {
  await Promise.all(
    Object.entries(config.symlinks).map(async ([_link, _target]) => {
      const link = resolve(_link);
      const target = resolve(dirname, _target);
      await exists(link) && await Deno.remove(link);
      await Deno.symlink(target, link);
      $.logStep(`Created ${link}`);
    }),
  );
});

$.logStep("Downloading fonts");
await $.logGroup(async () => {
  const { dist, links } = config.fonts;
  const fontBaseDir = resolve(dirname, dist);
  await $`mkdir -p ${fontBaseDir}`;
  await Promise.all(links.map(async (font) => {
    const fontPath = resolve(fontBaseDir, font.split("/").slice(-1)[0]);
    const data = await $.request(font).showProgress();
    await Deno.writeFile(fontPath, new Uint8Array(await data.arrayBuffer()));
    $.logStep(`Downloaded ${fontPath}`);
  }));
});

if (Deno.build.os === "linux") {
  $.logStep("Setting up apt and packages");
  await $.logGroup(async () => {
    if (flags["nonroot"]) {
      $.logStep("Skipped apt setup");
      return;
    }

    const { packages } = config.apt;
    await $`sudo apt-get update`;
    await $`sudo apt-get upgrade -y`;
    await $`sudo apt-get install -y ${packages}`;
    $.logStep(`Installed apt packages: ${packages.join(", ")}`);

    // Ref: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
    $.logStep("Installing Docker and Docker Compose with apt");
    if (flags["nonroot"]) {
      $.logStep("Skipped Docker setup");
      return;
    }

    const { gpgLink, gpgPath, installLink, packages: dockerPackages } =
      config.apt.docker;
    await exists(gpgPath) && await $`sudo rm ${gpgPath}`;
    await $`install -m 0755 -d /etc/apt/keyrings`;
    await $`sudo tee ${gpgPath}`
      .stdin($.request(gpgLink))
      .stdout("null");
    await $`sudo chmod a+r ${gpgPath}`;
    $.logStep("Added Docker's GPG key");

    const arch = (await $`dpkg --print-architecture`.text()).trim();
    const codename = (await $`lsb_release -cs`.text()).trim();
    await $`sudo tee /etc/apt/sources.list.d/docker2.list`
      .stdinText(
        `deb [arch=${arch} signed-by=${gpgPath}] ${installLink} ${codename} stable`,
      )
      .stdout("null");
    await $`sudo apt-get update`;
    $.logStep("Added Docker's apt repository");

    await $`sudo apt-get install -y ${dockerPackages}`;
    $.logStep(`Installed Docker's apt packages: ${dockerPackages.join(", ")}`);
  });
} else if (Deno.build.os === "darwin") {
  $.logStep("Setting up Homebrew");
  await $.logGroup(async () => {
    if (flags["nonroot"]) {
      $.logStep("Skipped Homebrew setup");
      return;
    }

    await $`bash`
      .stdin($.request(config.brew.installLink));
    await $`
      brew cleanup
      brew update
      brew upgrade
      brew doctor
      brew bundle --global --force
      brew cleanup --global --force
    `;
  });
}

$.logStep("Setting up rust with rustup");
await $.logGroup(async () => {
  await $`bash -s -- -y --no-modify-path`
    .stdin($.request(config.rust.installLink));
});

$.logStep("Setting up aquaproj");
await $.logGroup(async () => {
  await $`bash`
    .stdin($.request(config.aquaproj.installLink));
  await $`aqua install --all`.env({
    PATH: `${home}/.local/share/aquaproj-aqua/bin:${Deno.env.get("PATH")}`,
  });
});

$.log("Set up complete🎉🎉🎉");

$.log("Next steps");
$.logGroup(() => {
  for (const step of config.nextSteps) {
    $.log(step);
  }
});
