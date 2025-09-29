local remote_url = "https://github.com/ras0q/mise-lspconfig.nvim"
local local_dir = vim.env.HOME .. "/ghq/github.com/ras0q/mise-lspconfig.nvim"

local install_cmd = "LspInstall"

---@type LazyPluginSpec
return {
  dir = (vim.fn.getcwd() == local_dir) and local_dir or nil,
  url = (vim.fn.getcwd() == local_dir) and nil or remote_url,
  event = { "BufReadPre", "BufNewFile" },
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
  keys = {
    { "gd", "<cmd>lua vim.lsp.buf.definition()  <CR>", "Go to definition" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration() <CR>", "Go to declaration" },
  },
  cmd = { install_cmd },
}
