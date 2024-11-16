local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.font = wezterm.font 'Hack Nerd Font Mono'
config.window_background_opacity = 0.7

return config
