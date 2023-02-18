---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.wallpaper'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
---@diagnostic disable-next-line
local capi = { screen = screen } -- luacheck: ignore

capi.screen.connect_signal("request::desktop_decoration", function(s)
  s.wallpaper = awful.wallpaper({
    screen = s,
    widget = wibox.widget({
      widget = wibox.widget.imagebox,
      image = beautiful.wallpaper,
    }),
  })
end)
