--- @type vim.lsp.Config
return {
  root_dir = function(bufnr, cb)
    local js_runtime = require("utils").get_js_runtime(bufnr)
    local enabled = js_runtime.is_node and not js_runtime.is_deno
    if enabled then
      return cb(js_runtime.node_root_dir)
    end
  end,
}
