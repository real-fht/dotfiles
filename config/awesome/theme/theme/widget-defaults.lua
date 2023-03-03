---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.theme.widget-defaults'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi
local hcolor = require "helpers.color"
local hui = require "helpers.ui"

return function(theme)
  local widget_defaults = {}

  -- The following are fallbacks for AwesomeWM builtin widgets.
  -- For example the default tasklist uses bg_normal for unfocused clients, bg_focus
  -- for focused one, and fg_normal and fg_focus respectively.
  widget_defaults.bg_normal = theme.colors.black
  widget_defaults.bg_focus = theme.colors.black
  widget_defaults.bg_urgent = theme.colors.black2
  widget_defaults.bg_minimize = theme.colors.onebg
  widget_defaults.fg_normal = theme.colors.grey_fg2
  widget_defaults.fg_focus = theme.colors.white
  widget_defaults.fg_urgent = theme.colors.red
  widget_defaults.fg_minimize = theme.colors.light_grey

  -- Theme defaults for the basic button, found at ui/widget/button/basic.lua
  widget_defaults.basic_button = {}
  widget_defaults.basic_button.normal_bg = theme.colors.transparent
  widget_defaults.basic_button.hover_bg = theme.colors.black2
  widget_defaults.basic_button.press_bg = theme.colors.darker_black --[[ hcolor.darken(widget_defaults.basic_button.hover_bg, 10) ]]
  widget_defaults.basic_button.on_normal_bg = theme.colors.onebg
  widget_defaults.basic_button.on_hover_bg = hcolor.lighten(theme.colors.onebg, 10)
  widget_defaults.basic_button.on_press_bg = hcolor.darken(theme.colors.onebg, 10)
  -- -*- Border width
  widget_defaults.basic_button.normal_border_width = 0
  widget_defaults.basic_button.hover_border_width = 0
  widget_defaults.basic_button.press_border_width = 0
  widget_defaults.basic_button.on_normal_border_width = 0
  widget_defaults.basic_button.on_hover_border_width = 0
  widget_defaults.basic_button.on_press_border_width = 0
  -- -*- Border color.
  widget_defaults.basic_button.normal_border_color = theme.colors.transparent
  widget_defaults.basic_button.hover_border_color = theme.colors.transparent
  widget_defaults.basic_button.press_border_color = theme.colors.transparent
  widget_defaults.basic_button.on_normal_border_color = theme.colors.transparent
  widget_defaults.basic_button.on_hover_border_color = theme.colors.transparent
  widget_defaults.basic_button.on_press_border_color = theme.colors.transparent
  -- Button container
  widget_defaults.basic_button.shape = hui.rounded_rect(8)
  widget_defaults.basic_button.margins = 0
  widget_defaults.basic_button.paddings = 0

  -- Text button (just an extended basic button)
  widget_defaults.text_button = {}
  widget_defaults.text_button.normal_fg = theme.colors.white
  widget_defaults.text_button.hover_fg = hcolor.lighten(theme.colors.white, 10)
  widget_defaults.text_button.press_fg = hcolor.darken(widget_defaults.text_button.normal_fg, 10)
  widget_defaults.text_button.on_normal_fg = hcolor.lighten(widget_defaults.text_button.normal_fg, 15)
  widget_defaults.text_button.on_hover_fg = hcolor.lighten(widget_defaults.text_button.on_normal_fg, 10)
  widget_defaults.text_button.on_press_fg = hcolor.darken(widget_defaults.text_button.on_normal_fg, 10)

  -- Calendar.
  widget_defaults.calendar = {}
  widget_defaults.calendar.month_fg = theme.colors.accent
  widget_defaults.calendar.month_change_icon_fg = theme.colors.white
  widget_defaults.calendar.days_spacing = dpi(12)
  widget_defaults.calendar.current_day_fg = theme.colors.accent
  widget_defaults.calendar.current_day_bg = theme.colors.oneb2 .. theme.opacity_modifier
  widget_defaults.calendar.other_month_day_fg = theme.colors.grey_fg2
  widget_defaults.calendar.other_month_day_bg = theme.colors.transparent

  -- Menu.
  widget_defaults.menu = {}
  widget_defaults.menu.bg = theme.colors.black .. theme.opacity_modifier
  widget_defaults.menu.button_spacing = dpi(2)
  widget_defaults.menu.paddings = dpi(4)
  widget_defaults.menu.icon_color = theme.colors.accent
  widget_defaults.menu.button_height = dpi(30)
  widget_defaults.menu.button_hover_bg = theme.colors.onebg .. theme.opacity_modifier
  widget_defaults.menu.button_press_bg = theme.colors.onebg .. theme.opacity_modifier
  widget_defaults.menu.button_paddings = dpi(4)
  widget_defaults.menu.button_shape = hui.rounded_rect(dpi(8))
  widget_defaults.menu.icon_text_spacing = dpi(6)
  widget_defaults.menu.checkbox_color = theme.colors.green
  widget_defaults.menu.separator_color = theme.colors.onebg
  widget_defaults.menu.button_submenu_caret_color = theme.colors.grey

  return widget_defaults
end
