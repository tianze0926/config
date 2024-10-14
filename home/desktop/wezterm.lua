local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  'CodeNewRoman Nerd Font',
  'Noto Sans CJK SC',
}
config.font_size = 11.0
config.color_scheme = 'Ayu Light (Gogh)'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

wezterm.on('user-var-changed', function(window, pane, name, value)
  local actions = {
    play = "mpv '%s'",
    download = "brave '%s'",
  }
  if not actions[name] then return end
  io.popen(string.format(actions[name], value))
end)

return config
