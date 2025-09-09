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
    local bufname = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
    local dir = vim.fs.dirname(bufname)
    local findopts = { upward = true, path = dir }
    local deno_files = vim.fs.find({ "deno.json", "deno.jsonc", "deno.lock" }, findopts)
    if #deno_files > 0 then
      return cb(vim.fs.dirname(deno_files[1]))
    end

    local node_files = vim.fs.find({ "package.json" }, findopts)
    if #node_files == 0 then
      return cb(dir)
    end
  end,
}
