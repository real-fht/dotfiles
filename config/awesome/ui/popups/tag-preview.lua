---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.tag-preview'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local bling = require("modules.bling")
local wibox = require("wibox")

bling.widget.tag_preview.enable({
  show_client_content = true,
  scale = 0.105,
  placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
    awful.placement.bottom_left(c, {
      margins = { bottom = beautiful.useless_gap, left = beautiful.useless_gap + dpi(30) + dpi(6) },
      honor_workarea = true,
    })
  end,
  background_widget = wibox.widget({
    layout = wibox.layout.fixed.vertical,
    {
      image = beautiful.wallpaper,
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
      widget = wibox.widget.imagebox,
    },
    {
      widget = wibox.container.background,
      bg = beautiful.wibar_bg,
      forced_height = dpi(12),
      forced_width = dpi(1212121),
    },
  }),
})
