# dotfiles

## Setup

Prerequirements:

- mise
- winget (on Windows)
- xcode-select --install (on macOS)

On WSL, add `-E wsl` to the following command.

```bash
mise bootstrap \
  --from https://github.com/ras0q/dotfiles.git \
  --from-dir ~/ghq/github.com/ras0q/dotfiles \
  --force-dotfiles
```

## Checklist After Setup

### Common

- [ ] Install fonts to your OS
  - Run `bash _setup/font.sh` from this repository to download font files to `./dist`.
- Run `gh auth login`

### WSL2

- [ ] `ln -sf {{ path to npiperelay }} ~/.local/bin/npiperelay`

### macOS

- [ ] Open AeroSpace once to register its configured login startup.
- [ ] Grant Accessibility access to AeroSpace and KeyCastr when prompted.
- [ ] Sign in to 1Password and enable its SSH agent for Git authentication.
- [ ] Open MeetingBar and select a calendar; grant calendar access when prompted.
- [ ] Log out and back in to verify login startup and apply session-level preferences.

### Windows

- [ ] Install pacman and fish into "Git for Windows"
  - `eval "$(curl https://raw.githubusercontent.com/alexsarmiento/gitportable-pacman/refs/heads/master/install-pacman-git-bash.sh)"`
  - `pacman -Syu && pacman -S fish`
