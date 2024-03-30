local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action


-- size of window
config.initial_rows = 40
config.initial_cols = 130


-- window and decorations
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 0,
}
config.window_frame = {
	inactive_titlebar_bg = '#404040',
	active_titlebar_bg = '#202020',
	
	inactive_titlebar_fg = '#000000',
	active_titlebar_fg = '#ffffff',
	
	button_fg = '#cccccc',
	button_bg = '#2b2042',
	button_hover_fg = '#ffffff',
	button_hover_bg = '#3b3052',
}
config.window_background_opacity = 0.6
config.macos_window_background_blur = 15


-- pane
config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.6,
}


-- tab
config.hide_tab_bar_if_only_one_tab = true


-- fonts
config.font = wezterm.font 'Fira Code'
config.font_size = 12


-- cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Constant"


-- bell
config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75
}


-- command palette
config.command_palette_rows = 10
config.command_palette_font_size = 12
config.command_palette_bg_color = 'rgba(0,10,20, 0.5)'
config.command_palette_fg_color = 'rgba(150,150,150, 0.8)'


-- keys
config.keys = {
	{ -- open command palette
		key = 'P',
		mods = 'CMD|SHIFT',
		action = wezterm.action.ActivateCommandPalette
	},
	{ -- select pane with alphabet
		key = 'P',
		mods = 'CTRL|SHIFT',
		action = act.PaneSelect
	},
}


-- others
config.max_fps = 30
config.colors = {
	visual_bell = '#300505',
	cursor_border = '#4040f0',
	split = '#6090f0',
}
config.color_scheme = 'Material (terminal.sexy)'


return config
