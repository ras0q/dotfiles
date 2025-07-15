---@type vim.lsp.Config
return {
  workspace_required = true,
  root_markers = {},
  root_dir = function(bufnr, cb)
    local bufname = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
    local dir = vim.fs.dirname(bufname)
    local findopts = { upward = true, path = dir }
    local node_found = vim.fs.find({ "package.json" }, findopts)
    local deno_found = vim.fs.find({ "deno.json", "deno.jsonc", "deno.lock" }, findopts)
    if #node_found > 0 and #deno_found == 0 then
      return cb(vim.fs.dirname(node_found[1]))
    end
  end
}
