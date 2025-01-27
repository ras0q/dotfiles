# dotfiles

Cross-platform dotfiles for Windows, Mac, and Ubuntu.

## Setup

> [!CAUTION]
> In Windows environment, Run it in Git Bash (not cmd or PowerShell!)

```bash
DOTFILES_DIR=~/ghq/github.com/ras0q/dotfiles
git clone https://github.com/ras0q/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR
./install.sh
```

## Checklist After Setup

### Common

- [ ] Install fonts to your OS
  - Font files are downloaded in `./dist`

### WSL2

- [ ] `set -U NPIPERELAY_PATH {{ path to npiperelay }}`
