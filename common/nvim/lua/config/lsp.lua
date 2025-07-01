local M = {}

M.ensure_installed = {
  "ts_ls",
  "lua_ls",
  "gopls",
  "clangd",
  "pylsp",
}

vim.lsp.config("lua_ls", {
  ---@type vim.lsp.Config
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        })
      }
    }
  }
})
vim.lsp.enable(M.ensure_installed)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    -- Helper function to set up keymaps for LSP features
    local function setup_lsp_keymap(opts)
      if client:supports_method(opts.method) then
        vim.keymap.set("n", opts.keys, opts.func, { buffer = buf, desc = opts.desc })
      end
    end

    setup_lsp_keymap({
      method = "textDocument/definition",
      keys = "gd",
      func = vim.lsp.buf.definition,
      desc =
      "Go to definition"
    })
    setup_lsp_keymap({
      method = "textDocument/implementation",
      keys = "gi",
      func = vim.lsp.buf.implementation,
      desc =
      "Go to implementation"
    })
    setup_lsp_keymap({
      method = "textDocument/references",
      keys = "gr",
      func = vim.lsp.buf.references,
      desc =
      "Find references"
    })
    setup_lsp_keymap({
      method = "textDocument/hover",
      keys = "<leader>k",
      func = vim.lsp.buf.hover,
      desc =
      "Show hover documentation"
    })
    setup_lsp_keymap({
      method = "textDocument/rename",
      keys = "<leader>rn",
      func = vim.lsp.buf.rename,
      desc =
      "Rename symbol"
    })
    setup_lsp_keymap({
      method = "textDocument/codeAction",
      keys = "<leader>ca",
      func = vim.lsp.buf.code_action,
      desc =
      "Code actions"
    })

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

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
