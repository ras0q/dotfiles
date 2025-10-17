---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "auto",
    term_colors = true,
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = true,
    float = {
      transparent = true,
    },
    custom_highlights = function(colors)
      return {
        TreesitterContext = { bg = colors.base },
        TreesitterContextLineNumber = { bg = colors.base, fg = colors.rosewater },
      }
    end,
    auto_integrations = true,
    integrations = {
      treesitter_context = false,
    },
  },
  config = true,
  -- config = function()
  --   require("catppuccin").setup({
  --   })
  --   vim.cmd.colorscheme("catppuccin-latte")
  -- end,
}
