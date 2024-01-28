local wezterm = require 'wezterm'
local act = wezterm.action
local act_cb = wezterm.action_callback

-- Helper functions
local function copy_or_sigint(window, pane)
  local is_selection_active = string.len(window:get_selection_text_for_pane(pane)) ~= 0
  if is_selection_active then
      window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
  else
      window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
  end
end

-- common config
local config = {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = 'Catppuccin Latte',
  font = wezterm.font_with_fallback { '源ノ角ゴシック Code JP', 'Source Code Pro' },
  font_size = 10.0,
  hide_tab_bar_if_only_one_tab = true,
  initial_cols = 80,
  initial_rows = 20,
  keys = {
    -- Ctrl+C to copy to clipboard
    { key = 'c',     mods = 'CTRL',       action = act_cb(copy_or_sigint) },
    -- Ctrl+V to paste from clipboard
    { key = 'v',     mods = 'CTRL',       action = act.PasteFrom('Clipboard') },
    -- Alt+Shift+F to toggle fullscreen
    { key = 'f',     mods = 'SHIFT|META', action = act.ToggleFullScreen },
    -- Ctrl+Space to show launcher
    { key = 'Space', mods = 'CTRL',       action = act.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS|FUZZY' } },
  },
  mouse_bindings = {
    {
      -- Click only select text and doesn't open hyperlinks
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'PrimarySelection',
    },
    {
      -- Bind 'Up' event of CTRL-Click to open hyperlinks
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
    {
      -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.Nop,
    },
  },
  use_ime = true,
  window_background_opacity = 1,
}

-- platform specific config
local platform = wezterm.target_triple
if platform == "x86_64-pc-windows-msvc" then
  config.default_prog = { 'pwsh' }
  config.launch_menu = {
    { label = "PowerShell", args = { "pwsh" } },
    { label = "WSL2",       args = { "wsl", "~" } },
  }
elseif platform == "x86_64-apple-darwin" or platform == "aarch64-apple-darwin" then
  config.font_size = 12.0
else
end

return config
