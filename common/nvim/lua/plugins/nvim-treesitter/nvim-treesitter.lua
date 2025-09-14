---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ensure_installed = { "bash", "json", "jsonc", "markdown", "yaml", "regex" }
    require("nvim-treesitter").install(ensure_installed)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ensure_installed,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
