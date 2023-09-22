local wezterm = require 'wezterm'

local config = {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = 'Catppuccin Latte',
  default_prog = { 'pwsh' },
  font = wezterm.font_with_fallback {
    'SauceCodePro Nerd Font Mono',
    '源ノ角ゴシック Code JP',
  },
  font_size = 12.0,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    -- Alt+Shift+Fでフルスクリーン切り換え
    {
      key = 'f',
      mods = 'SHIFT|META',
      action = wezterm.action.ToggleFullScreen,
    },
  },
  use_ime = true,
  window_background_opacity = 0.9,
}

return config
