---@type vim.lsp.Config
return {
  cmd = { "gopls", "serve", "-mcp.listen=localhost:8092" },
}
