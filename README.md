# dotfiles-v2

Cross-platform dotfiles for Windows, Mac, and Ubuntu powered by [Deno](https://deno.land/).

## Setup (Windows)

```powershell
```

## Setup (Mac / Ubuntu)

```bash
# 1. Install dependencies with apt
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl wget unzip git

# 2. Clone the dotfiles repository
git clone https://github.com/ras0q/dotfiles-v2.git ~/ghq/github.com/ras0q/dotfiles-v2 # or preferred directory

# 3. Install Deno temporally for the initial setup
# TODO: setup with compiled binary, without Deno directly
curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/tmp/.deno sh

# 4. Run the initial setup
$DENO_INSTALL/bin/deno run ~/ghq/github.com/ras0q/dotfiles-v2/install_unix.ts
# 5. Clean up
rm -rf /tmp/.deno
```
