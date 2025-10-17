return {
  "echasnovski/mini.nvim",
  version = "*",
  lazy = false,
  config = function()
    -- Set up visually significant plugins during startup
    require("mini.basics").setup({
      mappings = {
        option_toggle_prefix = "m",
      },
    })
    require("mini.sessions").setup()
    require("mini.statusline").setup()

    -- Lazy loading other plugins
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Text editing
        require("mini.ai").setup()
        require("mini.comment").setup({
          mappings = {
            comment = "<C-c>",
            comment_line = "<C-c>",
            comment_visual = "<C-c>",
            textobject = "<C-c>",
          },
        })
        require("mini.move").setup()
        require("mini.pairs").setup()
        require("mini.surround").setup()

        -- General workflow
        local diff = require("mini.diff")
        diff.setup({
          mappings = {
            apply = "",
            reset = "",
            textobject = "",
          },
          -- FIXME: need to disable diff?
          -- https://codecompanion.olimorris.dev/installation.html#mini-diff
          -- source = diff.gen_source.none(),
        })
        require("mini.git").setup()

        -- Appearance
        require("mini.cursorword").setup()
        require("mini.hipatterns").setup()
        require("mini.icons").setup()
        require("mini.trailspace").setup()

        -- Other
        require("mini.fuzzy").setup()
      end,
    })
  end,
}
