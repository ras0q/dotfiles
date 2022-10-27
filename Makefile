ROOT_DIR   = $$PWD
COMMON_DIR = $(ROOT_DIR)/common
WSL_DIR    = $(ROOT_DIR)/wsl

# handle all targets as .PHONY
CMDS=$(shell grep -E -o "^[a-z_-]+" ./Makefile)
.PHONY: $(CMDS)

# default target
help:
	@echo "Commands:"
	@echo "---------"
	@echo $(CMDS) | sed 's/\s/\n/g'

init-wsl: link-wsl
	@echo "Initializing WSL..."
	@./init_wsl.sh

link-wsl: link-common
	@ln -sf $(WSL_DIR)/.config ~
	@ln -sf $(WSL_DIR)/.vscode-server/data/Machine/settings.json ~/.vscode-server/data/Machine
	@ln -sf $(WSL_DIR)/.wslconfig ~
	@sudo ln -sf $(WSL_DIR)/bin /usr/local
	@sudo ln -sf $(WSL_DIR)/wsl.conf /etc

link-common:
	@find $(COMMON_DIR) -type f | xargs -I{} ln -sf {} ~
