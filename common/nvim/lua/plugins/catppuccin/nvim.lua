---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true,
    float = {
      transparent = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    local is_applying_theme = false
    local function apply_theme()
      if is_applying_theme then return end
      is_applying_theme = true

      if vim.o.background == "light" then
        vim.cmd.colorscheme("catppuccin-latte")
      else
        vim.cmd.colorscheme("catppuccin-mocha")
      end

      is_applying_theme = false
    end

    apply_theme()
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = apply_theme,
    })
  end,
}
