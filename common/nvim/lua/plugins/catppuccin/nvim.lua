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

    local MODE_FG = {
      n = "blue",
      i = "green",
      v = "mauve",
      V = "mauve",
      ["\22"] = "mauve",
      t = "teal",
      c = "peach",
      R = "red",
      r = "red",
    }

    vim.api.nvim_create_autocmd({ "ColorScheme", "ModeChanged" }, {
      callback = function()
        if not vim.g.colors_name or not vim.g.colors_name:match("^catppuccin") then
          return
        end

        local C = require("catppuccin.palettes").get_palette()
        local fg_key = MODE_FG[vim.api.nvim_get_mode().mode:sub(1, 1)] or MODE_FG.n
        vim.api.nvim_set_hl(0, "TabLineSel", { bg = C.mantle, fg = C[fg_key], bold = true })
      end,
    })

    local is_applying_theme = false
    local function apply_theme()
      if is_applying_theme then return end
      is_applying_theme = true

      if vim.env.NVIM ~= nil then
        vim.cmd.colorscheme("darkblue")
      else
        if vim.o.background == "light" then
          vim.cmd.colorscheme("catppuccin-latte")
        else
          vim.cmd.colorscheme("catppuccin-mocha")
        end
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
