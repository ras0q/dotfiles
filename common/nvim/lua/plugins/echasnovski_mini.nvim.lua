return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      -- Text editing
      require("mini.comment").setup({
        mappings = {
          comment = "<C-c>",
          comment_line = "<C-c>",
          comment_visual = "<C-c>",
          textobject = "<C-c>",
        }
      })
      require("mini.pairs").setup()
      require("mini.surround").setup()

      -- General workflow
      -- require("mini.basics").setup() -- nonlazy
      require("mini.diff").setup({
        mappings = {
          apply = "dh",
          reset = "dH",
          textobject = "dh",
        }
      })
      require("mini.git").setup()

      -- Appearance
      require("mini.cursorword").setup()
      require("mini.hipatterns").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup()
      require("mini.notify").setup()
      -- require("mini.statusline").setup() -- nonlazy
      -- require("mini.tabline").setup() -- nonlazy
      require("mini.trailspace").setup()

      -- Other
      require("mini.fuzzy").setup()
    end,
  },
  {
    "echasnovski/mini.basics",
    lazy = false,
    config = function()
      require("mini.basics").setup({
        mappings = {
          option_toggle_prefix = "m",
        }
      })
    end
  },
  {
    "echasnovski/mini.statusline",
    lazy = false,
    config = function()
      require("mini.statusline").setup()
    end
  },
  {
    "echasnovski/mini.tabline",
    lazy = false,
    config = function()
      require("mini.tabline").setup()
    end
  },
}
