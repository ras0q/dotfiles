return {
  "echasnovski/mini.nvim",
  version = "*",
  lazy = false,
  config = function()
    -- Set up visually significant plugins during startup
    require("mini.basics").setup({
      mappings = {
        option_toggle_prefix = "m",
      }
    })
    require("mini.sessions").setup()
    require("mini.starter").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()

    -- Lazy loading other plugins
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
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
        require("mini.diff").setup({
          mappings = {
            apply = "",
            reset = "",
            textobject = "",
          }
        })
        require("mini.git").setup()

        -- Appearance
        require("mini.cursorword").setup()
        require("mini.hipatterns").setup()
        require("mini.icons").setup()
        require("mini.indentscope").setup()
        require("mini.trailspace").setup()

        -- Other
        require("mini.fuzzy").setup()
      end
    })
  end,
}
