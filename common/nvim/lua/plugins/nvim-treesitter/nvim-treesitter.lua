---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "bash", "json", "jsonc", "markdown", "yaml", "regex" },
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
    },
  },
}
