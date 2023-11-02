local wezterm = require 'wezterm'

-- common config
local config = {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = 'Catppuccin Latte',
  font = wezterm.font_with_fallback {
    '源ノ角ゴシック Code JP',
    'Source Code Pro'
  },
  font_size = 12.0,
  hide_tab_bar_if_only_one_tab = true,
  initial_cols = 80,
  initial_rows = 20,
  keys = {
    -- Alt+Shift+Fでフルスクリーン切り換え
    {
      key = 'f',
      mods = 'SHIFT|META',
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = "Space",
      mods = "CTRL",
      action = wezterm.action.ShowLauncherArgs {
        flags = 'LAUNCH_MENU_ITEMS|FUZZY'
      },
    },
  },
  use_ime = true,
  window_background_opacity = 0.9,
}

-- platform specific config
local platform = wezterm.target_triple
if platform == "x86_64-pc-windows-msvc" then
  config.default_prog = { 'pwsh' }
  config.launch_menu = {
    { label = "PowerShell", args = { "pwsh" } },
    { label = "WSL2",       args = { "wsl" } },
  }
elseif platform == "x86_64-apple-darwin" or platform == "aarch64-apple-darwin" then
else
end

return config
