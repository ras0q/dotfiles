# dotfiles-v2

Cross-platform dotfiles for Windows, Mac, and Ubuntu powered by [Deno](https://deno.land/).

## Contents

WIP

## Setup

### 1. Compile

Compile and download an artifact link from the [Compile install script with Deno](https://github.com/ras0q/dotfiles-v2/actions/workflows/compile-deno.yaml) workflow.

==TODO==: issue public link for the artifact

### 2. Setup Environment

Run the following command to setup environment with dotfiles.

Windows (Powershell):

```powershell
# Git is required for the install script
Invoke-WebRequest -Uri {artifact_link} -OutFile install.zip
Expand-Archive -Path install.zip -DestinationPath .
.\install
```

Mac / Ubuntu (bash):

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y wget unzip git
wget {artifact_link} -O install.zip
unzip install.zip
./install
```
