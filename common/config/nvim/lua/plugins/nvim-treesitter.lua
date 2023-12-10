return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require "nvim-treesitter.install".prefer_git = false
    require "nvim-treesitter.configs".setup {
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
