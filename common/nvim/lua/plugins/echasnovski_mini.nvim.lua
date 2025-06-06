return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      -- Text editing
      require("mini.comment").setup()
      require("mini.completion").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()

      -- General workflow
      require("mini.basics").setup()
      require("mini.diff").setup()
      require("mini.git").setup()

    -- Appearance
      require("mini.animate").setup()
      require("mini.cursorword").setup()
      require("mini.hipatterns").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup()
      require("mini.notify").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
      require("mini.trailspace").setup()

      -- Other
      require("mini.fuzzy").setup()
    end,
  },
}
