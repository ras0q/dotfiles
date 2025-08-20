return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = require("config.lsp").ensure_installed,
  },
  keys = {
    { "gd", "<cmd>lua vim.lsp.buf.definition()  <CR>", "Go to definition" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration() <CR>", "Go to declaration" },
  },
}
