return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "bash", "json", "jsonc", "markdown", "yaml" },
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
    },
  },
}
 
