---@type Wezterm
local wezterm = require("wezterm")
local act = wezterm.action
local act_cb = wezterm.action_callback
local nf = wezterm.nerdfonts

-- Platform detection
local target_triple = wezterm.target_triple
local is_windows = target_triple == "x86_64-pc-windows-msvc"
local is_macos = target_triple == "x86_64-apple-darwin" or target_triple == "aarch64-apple-darwin"

local config = wezterm.config_builder()

-- General
config.use_ime = true
config.window_close_confirmation = "NeverPrompt"
config.launch_menu = {}
if is_windows then
  config.default_prog = { "wsl", "~" }
  config.launch_menu = {
    { label = "WSL2",       args = { "wsl", "~" } },
    { label = "Git Bash",   args = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i", "zsh" } },
    { label = "PowerShell", args = { "pwsh" } },
  }
end

-- Colorscheme
local colorscheme                       = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
local latte                             = {
  rosewater = "#dc8a78",
  flamingo = "#dd7878",
  pink = "#ea76cb",
  mauve = "#8839ef",
  red = "#d20f39",
  maroon = "#e64553",
  peach = "#fe640b",
  yellow = "#df8e1d",
  green = "#40a02b",
  teal = "#179299",
  sky = "#04a5e5",
  sapphire = "#209fb5",
  blue = "#1e66f5",
  lavender = "#7287fd",
  text = "#4c4f69",
  subtext1 = "#5c5f77",
  subtext0 = "#6c6f85",
  overlay2 = "#7c7f93",
  overlay1 = "#8c8fa1",
  overlay0 = "#9ca0b0",
  surface2 = "#acb0be",
  surface1 = "#bcc0cc",
  surface0 = "#ccd0da",
  crust = "#dce0e8",
  mantle = "#e6e9ef",
  base = "#eff1f5",
}
colorscheme.tab_bar.active_tab.bg_color = latte.base
colorscheme.tab_bar.active_tab.fg_color = latte.teal
colorscheme.tab_bar.inactive_tab_edge   = "None"
config.color_schemes                    = config.color_schemes or {}
config.colors                           = colorscheme

-- Opacity
config.window_background_opacity        = 0.7
if is_windows then
  config.win32_system_backdrop = "Acrylic"
elseif is_macos then
  config.macos_window_background_blur = 30
end

-- Window
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
config.window_frame = {
  active_titlebar_bg = config.colors.background,
  inactive_titlebar_bg = config.colors.background,
}
config.window_padding = {
  left = "2cell",
  right = "2cell",
}

-- Tab bar
wezterm.on(
  "format-tab-title",
  function(tab)
    local title = tab.active_pane.title
    if title == "wsl.exe" or title == "wslhost.exe" then
      return nf.dev_linux .. " WSL2"
    elseif title == "bash.exe" or title == "zsh.exe" then
      return nf.dev_git .. " Git Bash"
    elseif title == "pwsh.exe" then
      return nf.md_powershell .. " PowerShell"
    else
      return nf.md_console_line .. " " .. title:gsub("%.exe$", "")
    end
  end
)

-- Font
config.font = wezterm.font_with_fallback({
  { family = "源ノ角ゴシック Code JP", weight = "Medium" },
  { family = "Symbols Nerd Font" },
})
config.font_size = is_macos and 12.0 or 10.0

-- Keybindings (based on Zellij)
local spawn_tab = act_cb(function(window, pane)
  wezterm.log_info("perform", #config.launch_menu)
  if #config.launch_menu <= 1 then
    window:perform_action(act.SpawnTab("CurrentPaneDomain"), pane)
  else
    window:perform_action(act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|FUZZY" }), pane)
  end
end)

config.leader = { key = "p", mods = "CTRL" }
config.keys = {
  -- Cmd+T to show launcher
  {
    key = "t",
    mods = "SUPER",
    action = spawn_tab,
  },
  -- Ctrl+Shift+T to show launcher
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = spawn_tab,
  },
  -- Cmd+Shift+T to show launcher
  {
    key = "t",
    mods = "SUPER|SHIFT",
    action = spawn_tab,
  },
  -- Leader+D to split vertically
  {
    key = "d",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- Leader+N to create a new window
  {
    key = "n",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  -- Leader+R to split horizontally
  {
    key = "r",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  -- Leader+T to create a new tab
  {
    key = "t",
    mods = "LEADER",
    action = spawn_tab,
  },
  -- Leader+X to close current pane
  {
    key = "x",
    mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = false }),
  },
}
if is_windows then
  -- Ctrl+C to copy to clipboard
  table.insert(config.keys, {
    key = "c",
    mods = "CTRL",
    action = act_cb(function(window, pane)
      local is_selection_active = #window:get_selection_text_for_pane(pane) > 0
      if is_selection_active then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
      else
        window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
      end
    end),
  })
  -- Ctrl+V to paste from clipboard
  table.insert({
    key = "v",
    mods = "CTRL",
    action = act.PasteFrom("Clipboard"),
  })
  -- Ctrl+W to close current tab
  table.insert({
    key = "w",
    mods = "CTRL",
    action = act.CloseCurrentPane({ confirm = true }),
  })
end

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
  direction_keys = { "h", "j", "k", "l" },
  modifiers = {
    move = "CTRL",   -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
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

return config
