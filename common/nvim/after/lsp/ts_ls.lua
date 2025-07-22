---@type vim.lsp.Config
return {
  single_file_support = false,
  workspace_required = true,
  root_markers = {},
  root_dir = function(bufnr, cb)
    local bufname = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
    local dir = vim.fs.dirname(bufname)
    local findopts = { upward = true, path = dir }
    local node_files = vim.fs.find({ "package.json" }, findopts)
    local deno_files = vim.fs.find({ "deno.json", "deno.jsonc", "deno.lock" }, findopts)
    if #node_files > 0 and #deno_files == 0 then
      return cb(vim.fs.dirname(node_files[1]))
    end
  end
}
