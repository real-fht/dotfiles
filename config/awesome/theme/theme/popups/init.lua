---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.theme.popups'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local popups = { popups = {} }

  -- Calendar popup.
  popups.popups.calendar = {}
  -- NOTE: Most the of the calendar theming is managed under widgets-default, so go
  -- check that file to change settings like date spacing, etc.
  popups.popups.calendar.bg = theme.colors.black .. theme.opacity_modifier
  popups.popups.calendar.paddings = dpi(12)

  -- Layout Picker popup.
  popups.popups.layout_picker = {}
  popups.popups.layout_picker.bg = theme.colors.black .. theme.opacity_modifier
  popups.popups.layout_picker.paddings = dpi(12)
  popups.popups.layout_picker.button_size = dpi(30)
  popups.popups.layout_picker.button_spacing = dpi(6)
  -- Layout list contained inside the layout picker popup
  popups.layoutlist_bg_normal = theme.colors.transparent
  popups.layoutlist_bg_selected = theme.colors.onebg .. theme.opacity_modifier

  -- Systray popup settings.
  popups.popups.systray = {}
  popups.popups.systray.bg = theme.colors.black .. theme.opacity_modifier
  popups.popups.systray.paddings = dpi(12)
  popups.popups.systray.icon_size = dpi(24)
  -- Required to be like so.
  popups.systray_icon_spacing = dpi(6)

  -- Tag preview settings.
  -- Can't do something pretty with variable declarations since tag preview is
  -- a bling widget and thus they enforce these variable names.
  theme.tag_preview_client_bg = theme.colors.black2
  theme.tag_preview_client_border_color = theme.colors.transparent
  theme.tag_preview_client_border_radius = theme.corner_radius
  theme.tag_preview_client_border_width = theme.border_width
  theme.tag_preview_client_opacity = 0.5
  theme.tag_preview_widget_bg = theme.colors.darker_black
  theme.tag_preview_widget_border_color = theme.colors.transparent
  theme.tag_preview_widget_border_radius = 0
  theme.tag_preview_widget_border_width = 0
  theme.tag_preview_widget_margin = dpi(4)

  return popups
end
