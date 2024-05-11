return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.completion").setup()
      require("mini.cursorword").setup()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
      require("mini.statusline").setup()
      require("mini.trailspace").setup()
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
}
