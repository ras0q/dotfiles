local M = {}

M.ensure_installed = {
  "denols",
  "ts_ls",
  "lua_ls",
  "gopls",
  "clangd",
  -- "pylsp",
}
vim.lsp.enable(M.ensure_installed)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    -- Set up keymaps for LSP features
    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
    end

    if client:supports_method("textDocument/implementation") then
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "Go to implementation" })
    end

    if client:supports_method("textDocument/references") then
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "Find references" })
    end

    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "<leader>k",
        function() vim.lsp.buf.hover({ border = "single" }) end,
        { buffer = buf, desc = "Show hover documentation" })
    end

    if client:supports_method("textDocument/rename") then
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "Rename symbol" })
    end

    if client:supports_method("textDocument/codeAction") then
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code actions" })
    end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

return M
