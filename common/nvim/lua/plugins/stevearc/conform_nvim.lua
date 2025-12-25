local js_formatter = function(bufnr)
  local js_runtime = require("utils").get_js_runtime(bufnr)
  if js_runtime.is_deno or not js_runtime.is_node then
    return { "deno_fmt" }
  else
    return { "biome", "prettierd", "prettier", stop_after_first = true }
  end
end

---@type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local js_fts = (vim.lsp.config["denols"] and vim.lsp.config["denols"].filetypes) or {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "json",
      "jsonc",
    }

    local formatters_by_ft = {}
    for _, ft in ipairs(js_fts) do
      formatters_by_ft[ft] = js_formatter
    end

    return {
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
      },
      formatters_by_ft = formatters_by_ft,
    }
  end,
  config = function(_, opts)
    require("conform").setup(opts)
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
