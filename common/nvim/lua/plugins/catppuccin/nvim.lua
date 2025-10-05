---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "auto",
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
    })
    vim.cmd.colorscheme("catppuccin-latte")
  end,
}
