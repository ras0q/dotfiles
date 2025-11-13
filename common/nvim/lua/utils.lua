local M = {}

function M.get_js_runtime(bufnr)
  local bufname = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
  local dir = vim.fs.dirname(bufname)
  local findopts = { upward = true, path = dir }
  local deno_files = vim.fs.find({ "deno.json", "deno.jsonc", "deno.lock" }, findopts)
  local node_files = vim.fs.find({ "package.json" }, findopts)

  return {
    is_deno = #deno_files > 0,
    is_node = #node_files > 0,
    deno_root_dir = #deno_files > 0 and vim.fs.dirname(deno_files[1]) or dir,
    node_root_dir = #node_files > 0 and vim.fs.dirname(node_files[1]) or dir,
  }
end

return M
