vim.opt.completeopt = {
  "fuzzy",
  "popup",
  "menuone",
  "noinsert",
}
vim.opt.pumheight = 15

vim.lsp.log.set_level("warn")

-- NOTE: some plugins handle LSP-related configurations:
-- - Language server configuration: nvim-lspconfig
-- - Language server installation: mason-lspconfig.nvim
-- - Auto-formatting: conform.nvim
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    -- Set LSP keybindings
    -- See https://neovim.io/doc/user/lsp.html#lsp-defaults
    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = true,
      float = {
        source = true,
        border = "rounded",
      },
    })
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = buf, desc = "Show diagnostics" })

    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
    end

    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "<leader>k",
        function() vim.lsp.buf.hover({ border = "single" }) end,
        { buffer = buf, desc = "Show hover documentation" })
    end


    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })
    end

    if client:supports_method("textDocument/inlineCompletion") then
      local skip_fts = { "text", "toggleterm" }
      for _, ft in ipairs(skip_fts) do
        if vim.bo[buf].filetype == ft then
          return
        end
      end

      vim.lsp.inline_completion.enable(true, { bufnr = buf })
      vim.keymap.set("i", "<Tab>", function()
        if not vim.lsp.inline_completion.get() then
          return "<Tab>"
        end
        -- close the completion popup if it's open
        if vim.fn.pumvisible() == 1 then
          return "<C-e>"
        end
      end, {
        expr = true,
        buffer = buf,
        desc = "Accept the current inline completion",
      })
    end
  end,
})
