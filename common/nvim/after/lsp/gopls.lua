---@type vim.lsp.Config
return {
  -- https://go.dev/gopls/features/mcp#attached-mode
  -- codex mcp add gopls --url http://localhost:8092
  -- gopls mcp -instructions > /path/to/contextFile.md
  cmd = { "gopls", "serve", "-mcp.listen=localhost:8092" },
}
