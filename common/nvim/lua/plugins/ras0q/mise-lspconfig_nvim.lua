local remote_url = "https://github.com/ras0q/mise-lspconfig.nvim"
local local_dir = vim.env.HOME .. "/ghq/github.com/ras0q/mise-lspconfig.nvim"
local is_development = vim.fn.getcwd() == local_dir

local install_cmd = "LspInstall"

---@type LazyPluginSpec
return {
  dir = is_development and local_dir or nil,
  url = is_development and nil or remote_url,
  event = { "BufReadPre", "BufNewFile" },
  enabled = is_development,
  opts = {
    commands = {
      install = {
        name = install_cmd,
      },
    },
    lspconfig = {},
    mise = {
      args = {
        global = { "--env", "local" },
      },
    },
  },
  cmd = { install_cmd },
}
