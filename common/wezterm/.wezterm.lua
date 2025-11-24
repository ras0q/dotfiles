---@type Wezterm
local wezterm = require("wezterm")
local act = wezterm.action
local act_cb = wezterm.action_callback

-- Platform detection
local target_triple = wezterm.target_triple
local is_windows = target_triple == "x86_64-pc-windows-msvc"
local is_macos = target_triple == "x86_64-apple-darwin" or target_triple == "aarch64-apple-darwin"

local config = wezterm.config_builder()

-- Colorscheme
config.color_scheme = "Catppuccin Latte"
config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#eff1f5", -- latte base
      fg_color = "#179299", -- latte teal
    },
    inactive_tab = {
      bg_color = "#e6e9ef", -- latte mantle
      fg_color = "#6c6f85", -- latte subtext0
    },
    inactive_tab_hover = {
      bg_color = "#dce0e8", -- latte crust
      fg_color = "#6c6f85", -- latte subtext0
    },
    new_tab = {
      bg_color = "#ccd0da", -- latte surface0
      fg_color = "#5c5f77", -- latte subtext1,
    },
    new_tab_hover = {
      bg_color = "#ccd0da", -- latte surface0
      fg_color = "#fe640b", -- latte peach
    },
  },
}

-- Opacity
config.window_background_opacity = 0.6
if is_windows then
  config.win32_system_backdrop = "Acrylic"
elseif is_macos then
  config.macos_window_background_blur = 20
end

-- Window
config.initial_cols = 80
config.initial_rows = 20
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
config.window_frame = {
  font_size = 12.0,
  active_titlebar_bg = "#ccd0da",   -- latte surface0
  inactive_titlebar_bg = "#bcc0cc", -- latte surface1
}
config.window_padding = {
  left = "2cell",
  right = "2cell",
}

-- Font
config.font = wezterm.font_with_fallback({
  { family = "源ノ角ゴシック Code JP", weight = "Medium" },
  { family = "Symbols Nerd Font" },
})
config.font_size = is_macos and 12.0 or 10.0

-- Keybindings
config.keys = {
  -- Ctrl+C to copy to clipboard
  {
    key = "c",
    mods = "CTRL",
    action = act_cb(function(window, pane)
      local is_selection_active = string.len(window:get_selection_text_for_pane(pane)) ~= 0
      if is_selection_active then
        window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
      else
        window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
      end
    end),
  },
  -- Ctrl+V to paste from clipboard
  {
    key = "v",
    mods = "CTRL",
    action = act.PasteFrom("Clipboard"),
  },
  -- Alt+Shift+F to toggle fullscreen
  {
    key = "f",
    mods = "SHIFT|META",
    action = act.ToggleFullScreen,
  },
  -- Ctrl+Space to show launcher
  {
    key = "Space",
    mods = "CTRL",
    action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|FUZZY" }),
  },
}
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { "h", "j", "k", "l" },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = "CTRL",   -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = "info",
})

-- Mouse bindings
config.mouse_bindings = {
  -- Click only select text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("PrimarySelection"),
  },
  -- Bind 'Up' event of CTRL-Click to open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.Nop,
  },
}

-- IME support
config.use_ime = true

-- Launch menu
if is_windows then
  config.default_prog = { "wsl", "~" }
  config.launch_menu = {
    { label = "WSL2",       args = { "wsl", "~" } },
    { label = "Git Bash",   args = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i", "zsh" } },
    { label = "PowerShell", args = { "pwsh" } },
  }
end

return config
