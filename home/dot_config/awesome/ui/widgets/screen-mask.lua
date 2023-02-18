---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.screen-mask'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local screen_mask = { mt = {} }

function screen_mask.background(s)
  local background = wibox.widget({
    widget = wibox.widget.imagebox,
    resize = true,
    horizontal_fit_policy = "fit",
    vertical_fit_policy = "fit",
    image = beautiful.wallpaper,
  })

  local blur = wibox.widget({
    widget = wibox.container.background,
    bg = beautiful.colors.black,
  })

  return awful.popup({
    type = "splash",
    screen = s,
    placement = awful.placement.maximize,
    visible = false,
    ontop = true,
    widget = {
      layout = wibox.layout.stack,
      background,
      blur,
    },
  })
end

return setmetatable(screen_mask, screen_mask.mt)
