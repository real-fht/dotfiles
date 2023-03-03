---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.theme.wibar'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local wibar = {}

  -- Main wibar settings, this will apply to the wibar "bar".
  wibar.wibar = {}
  wibar.wibar.bg = theme.bg_normal .. theme.opacity_modifier
  wibar.wibar.item_bg = theme.colors.transparent
  wibar.wibar.position = "top"
  wibar.wibar.height = dpi(42)
  wibar.wibar.paddings = dpi(6)

  -- Taglist widget settings
  wibar.wibar.taglist = {}
  wibar.wibar.taglist.item_spacing = dpi(6)
  wibar.wibar.taglist.item_height = dpi(8)
  wibar.wibar.taglist.item_width_focus = dpi(30)
  wibar.wibar.taglist.item_width_normal = dpi(8)
  wibar.wibar.taglist.item_width_occupied = dpi(12)
  wibar.wibar.taglist.item_width_urgent = dpi(24)
  -- -*-
  wibar.wibar.taglist.item_color_focus = theme.accent
  wibar.wibar.taglist.item_color_normal = theme.colors.oneb2
  wibar.wibar.taglist.item_color_occupied = theme.accent
  wibar.wibar.taglist.item_color_urgent = theme.colors.red

  -- Tasklist widget settings.
  wibar.wibar.tasklist = {}
  wibar.wibar.tasklist.item_spacing = dpi(6)
  wibar.wibar.tasklist.item_paddings = dpi(3) -- inner paddings
  -- -*-
  wibar.wibar.tasklist.item_bg_focus = theme.colors.oneb3
  wibar.wibar.tasklist.item_bg_normal = theme.colors.onebg
  wibar.wibar.tasklist.indicator_color_focus = theme.accent
  wibar.wibar.tasklist.indicator_color_normal = theme.colors.grey
  wibar.wibar.tasklist.indicator_color_urgent = theme.colors.red
  wibar.wibar.tasklist.indicator_color_minimized = theme.colors.transparent
  wibar.wibar.tasklist.indicator_width_focus = dpi(12)
  wibar.wibar.tasklist.indicator_width_normal = dpi(4)
  wibar.wibar.tasklist.indicator_width_urgent = dpi(8)
  wibar.wibar.tasklist.indicator_width_minimized = 0

  return wibar
end
