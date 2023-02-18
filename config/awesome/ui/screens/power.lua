---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.screens.power'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local gobject = require("gears.object")
local gtable = require("gears.table")
local wibox = require("wibox")
local widgets = require("ui.widgets")

local power, instance = {}, nil

function power:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true
  self:emit_signal("visibility", true)
end

function power:hide()
  self.popup.visible = false
  self:emit_signal("visibility", false)
end

function power:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function new()
  local ret = gobject({})
  gtable.crush(ret, power, true)

  local message = widgets.text({
    text = "Sayonara, Onii-chan~!",
    color = beautiful.colors.white,
    size = 17,
    Halign = "center",
  })
  local message_small = widgets.text({
    text = "I will miss your forever~~",
    color = beautiful.colors.oneb3,
    size = 12,
    halign = "center",
  })

  ret.popup = awful.popup({
    screen = awful.screen.focused(),
    ontop = true,
    visible = false,
    placement = awful.placement.maximize,
    bg = beautiful.power_screen_bg,
    widget = wibox.container.place({
      layout = wibox.layout.fixed.vertical,
      wibox.container.place({
        layout = wibox.layout.fixed.vertical,
        message,
        message_small,
      }, "center", "center"),
    }),
  })

  return ret
end

instance = instance or new()
return instance
