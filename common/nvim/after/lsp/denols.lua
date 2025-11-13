---@type vim.lsp.Config
return {
  -- https://docs.deno.com/runtime/reference/lsp_integration/#language-ids
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "json",
    "jsonc",
    "markdown",
  },
  single_file_support = true,
  workspace_required = true,
  root_markers = {},
  root_dir = function(bufnr, cb)
    local js_runtime = require("utils").get_js_runtime(bufnr)
    local enabled = js_runtime.is_deno
        or (not js_runtime.is_node and vim.bo.filetype ~= "markdown")
    if enabled then
      return cb(js_runtime.deno_root_dir)
    end
  end,
}
