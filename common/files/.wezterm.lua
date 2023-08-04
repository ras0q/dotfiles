local wezterm = require 'wezterm'

local config = {
  color_scheme = 'One Light (Gogh)',
  font = wezterm.font_with_fallback {
    -- 'SauceCodePro NF',
    'Source Code Pro',
  },
  default_prog = { 'pwsh' },
  keys = {},
  use_ime = true,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
}

return config
