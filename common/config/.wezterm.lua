local wezterm = require 'wezterm'

local config = {
  color_scheme = 'Catppuccin Latte',
  font = wezterm.font_with_fallback {
    'SauceCodePro Nerd Font Mono',
    '源ノ角ゴシック Code JP',
  },
  default_prog = { 'pwsh' },
  keys = {},
  use_ime = true,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
}

return config
