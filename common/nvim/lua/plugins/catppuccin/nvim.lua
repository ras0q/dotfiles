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
      auto_integrations = true,
    })
    vim.cmd.colorscheme("catppuccin-latte")
  end,
}
