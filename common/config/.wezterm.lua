local wezterm = require 'wezterm'

local config = {
  color_scheme = 'Catppuccin Latte',
  font = wezterm.font_with_fallback {
    '源ノ角ゴシック Code JP',
  },
  font_size = 12.0,
  default_prog = { 'pwsh' },
  use_ime = true,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  window_background_opacity = 0.9,
  keys = {
    -- Alt+Shift+Fでフルスクリーン切り換え
    {
      key = 'f',
      mods = 'SHIFT|META',
      action = wezterm.action.ToggleFullScreen,
    },
  },
}

return config
