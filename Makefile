ROOT_DIR    := $$PWD
COMMON_DIR  := $(ROOT_DIR)/common
WSL_DIR     := $(ROOT_DIR)/wsl

# handle all targets as .PHONY
CMDS=$(shell grep -E -o "^[a-z_-]+" ./Makefile)
.PHONY: $(CMDS)

# default target
help:
	@echo "Commands:"
	@echo "---------"
	@echo $(CMDS) | sed 's/\s/\n/g'

# --------------------
# initialize scripts
# --------------------
init-wsl: link-common link-wsl setup-apt setup-brew setup-asdf setup-visudo setup-fish

# --------------------
# link scripts
# --------------------
link-common:
	@find $(COMMON_DIR) -type f | xargs -I{} ln -sf {} ~

link-wsl:
	@ln -sf $(WSL_DIR)/.config ~
	@ln -sf $(WSL_DIR)/.vscode-server/data/Machine/settings.json ~/.vscode-server/data/Machine
	@ln -sf $(WSL_DIR)/.wslconfig ~
	@sudo ln -sf $(WSL_DIR)/bin /usr/local
	@sudo ln -sf $(WSL_DIR)/wsl.conf /etc

# --------------------
# setup scripts
# --------------------
setup-apt:
	@sudo apt update -y
	@sudo apt upgrade -y

setup-brew:
	@bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@brew doctor
	@brew update
	@brew upgrade
	@brew bundle --global
	@brew bundle cleanup --global

setup-asdf:
	@cat ~/.tool-versions | awk '{print "asdf plugin add " $1}' | bash
	@asdf install

setup-visudo:
	@echo "ras     ALL=NOPASSWD: /usr/sbin/service"
	@echo "ras     ALL=NOPASSWD: /usr/sbin/hwclock"

setup-fish:
	@cat /etc/shells | grep fish || sudo bash -c "echo $(which fish) >> /etc/shells"
	@chsh -s $(which fish)

# --------------------
# utility scripts
# --------------------
dump:
	@brew bundle --global dump -f
	@code --list-extensions > code-extensions.txt

