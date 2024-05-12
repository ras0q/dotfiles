local wezterm = require("wezterm")
local act = wezterm.action
local act_cb = wezterm.action_callback

-- Helper functions
local function copy_or_sigint(window, pane)
	local is_selection_active = string.len(window:get_selection_text_for_pane(pane)) ~= 0
	if is_selection_active then
		window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
	else
		window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
	end
end

-- common config
local config = {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Catppuccin Latte",
	colors = {
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
	},
	font = wezterm.font_with_fallback({ "源ノ角ゴシック Code JP", "Symbols Nerd Font" }),
	font_size = 10.0,
	initial_cols = 80,
	initial_rows = 20,
	keys = {
		-- Ctrl+C to copy to clipboard
		{ key = "c", mods = "CTRL", action = act_cb(copy_or_sigint) },
		-- Ctrl+V to paste from clipboard
		{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
		-- Alt+Shift+F to toggle fullscreen
		{ key = "f", mods = "SHIFT|META", action = act.ToggleFullScreen },
		-- Ctrl+Space to show launcher
		{ key = "Space", mods = "CTRL", action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|FUZZY" }) },
	},
	mouse_bindings = {
		{
			-- Click only select text and doesn't open hyperlinks
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("PrimarySelection"),
		},
		{
			-- Bind 'Up' event of CTRL-Click to open hyperlinks
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
		{
			-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.Nop,
		},
	},
	use_ime = true,
	window_background_opacity = 1,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	window_frame = {
		font_size = 12.0,
		active_titlebar_bg = "#ccd0da", -- latte surface0
		inactive_titlebar_bg = "#bcc0cc", -- latte surface1
	},
	window_padding = {
		left = "2cell",
		right = "2cell",
	},
}

-- platform specific config
local platform = wezterm.target_triple
if platform == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh" }
	config.launch_menu = {
		{ label = "PowerShell", args = { "pwsh" } },
		{ label = "WSL2", args = { "wsl", "~" } },
	}
elseif platform == "x86_64-apple-darwin" or platform == "aarch64-apple-darwin" then
	config.font_size = 12.0
else
end

return config
