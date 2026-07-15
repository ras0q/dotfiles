---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  build = function()
    require("catppuccin").compile()
  end,
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
    -- FIXME: slow on nvim 0.12 which using `vim.pack`
    -- auto_integrations = true,
    integrations = {
      treesitter_context = false,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    local is_applying_theme = false
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function()
        if is_applying_theme then return end
        is_applying_theme = true

        if vim.o.background == "light" then
          vim.cmd.colorscheme("catppuccin-latte")
        else
          vim.cmd.colorscheme("catppuccin-mocha")
        end

        is_applying_theme = false
      end,
    })
  end,
}
