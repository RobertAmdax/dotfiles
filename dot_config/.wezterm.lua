-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set Catppuccin color scheme (choose from Mocha, Macchiato, Frappe, Latte)
config.color_scheme = "Catppuccin Mocha"

-- Font settings
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")
config.font_size = 19

-- Window and UI behavior
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

-- Return the final configuration to wezterm
return config
