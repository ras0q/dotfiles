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
        FloatBorder = { fg = colors.lavender },
        TreesitterContext = { bg = colors.base },
        TreesitterContextLineNumber = { bg = colors.base, fg = colors.rosewater },
      }
    end,
    auto_integrations = true,
    integrations = {
      treesitter_context = false,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-latte")
    vim.api.nvim_create_user_command("ColorschemeToggle", function()
      local current = vim.g.colors_name
      if current == "catppuccin-latte" then
        vim.cmd.colorscheme("catppuccin-mocha")
      else
        vim.cmd.colorscheme("catppuccin-latte")
      end
    end, {})
  end,
}
