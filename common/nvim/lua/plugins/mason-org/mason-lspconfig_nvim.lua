---@type LazyPluginSpec
return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = {
      "denols",
      "gopls",
      "lua_ls",
      "ts_ls",
      "yamlls",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim" },
    { "neovim/nvim-lspconfig" },
  },
}
