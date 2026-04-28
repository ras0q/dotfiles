--- @param server string
--- @param cmd? string
local function enable_server(server, cmd)
  if vim.fn.executable(cmd or server) == 1 then
    vim.lsp.enable(server)
  else
    vim.notify(string.format("LSP server '%s' not enabled: executable not found", server), vim.log.levels.WARN)
  end
end

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    enable_server("denols", "deno")
    enable_server("gopls")
    enable_server("lua_ls", "lua-language-server")
    enable_server("sourcekit", "sourcekit-lsp")
    enable_server("tsgo")
  end,
}
