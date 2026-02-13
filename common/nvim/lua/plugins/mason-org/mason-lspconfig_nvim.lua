---@type LazyPluginSpec
return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim" },
    { "neovim/nvim-lspconfig" },
  },
}
