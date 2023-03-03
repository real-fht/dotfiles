---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.colors'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local decorations = {}
  -- Client decoration config (borders)
  decorations.useless_gap = dpi(8)
  decorations.border_width = 0
  decorations.border_color_normal = theme.colors.transparent
  decorations.border_color_active = theme.colors.oneb3
  decorations.border_color_marked = theme.colors.green

  -- Client decoration config (titlebars)
  decorations.titlebar = {}
  decorations.titlebar.size = dpi(36)
  decorations.titlebar.bg_focus = theme.colors.darker_black .. theme.opacity_modifier
  decorations.titlebar.bg_normal = theme.colors.darker_black .. theme.opacity_modifier
  decorations.titlebar.button_spacing = dpi(4)
  decorations.titlebar.close_button_color_focus = theme.colors.red
  decorations.titlebar.maximize_button_color_focus = theme.colors.green
  decorations.titlebar.minimize_button_color_focus = theme.colors.yellow
  decorations.titlebar.close_button_color_normal = theme.colors.onebg
  decorations.titlebar.maximize_button_color_normal = theme.colors.onebg
  decorations.titlebar.minimize_button_color_normal = theme.colors.onebg
  decorations.titlebar.button_size = dpi(14)
  decorations.titlebar.paddings = { top = dpi(8), bottom = dpi(8), left = dpi(2), right = dpi(2) }

  return decorations
end
