---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.screens.power'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local gobject = require("gears.object")
local gtable = require("gears.table")
local helpers = require("helpers")
local wibox = require("wibox")
local widgets = require("ui.widgets")

local power, instance = {}, nil

function power:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true

  self.keygrabber = awful.keygrabber({
    keypressed_callback = function(_, _, key, _) --luacheck: ignore
      key = key:lower()
      if key == "q" or key == "escape" then
        self:hide()
      elseif key == "r" then
        awful.spawn("systemctl reboot")
      elseif key == "p" then
        awful.spawn("systemctl poweroff")
      elseif key == "s" then
        awful.spawn("systemctl suspend")
      elseif key == "e" then
        awesome.quit()
      end
    end,
  })
  self.keygrabber:start()

  self:emit_signal("visibility", true)
end

function power:hide()
  self.popup.visible = false
  pcall(self.keygrabber.stop, self.keygrabber)
  self:emit_signal("visibility", false)
end

function power:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function mkbutton(icon, color, on_press)
  return widgets.button.text.normal({
    forced_height = beautiful.power_screen_button_size,
    forced_width = beautiful.power_screen_button_size,
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.power_screen_button_bg,
    hover_border_color = color,
    hover_border_width = 2,
    halign = "center",
    valign = "center",
    normal_fg = color,
    hover_fg = color,
    press_fg = color,
    text = icon.icon,
    font = icon.font,
    size = 14,
    on_press = on_press,
  })
end

local function new()
  local ret = gobject({})
  gtable.crush(ret, power, true)

  ret.keygrabber = nil

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

  local buttons = wibox.widget({
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.power_screen_button_spacing,
    mkbutton(beautiful.icons.poweroff, beautiful.colors.red, function()
      awful.spawn("systemctl poweroff")
    end),
    mkbutton(beautiful.icons.reboot, beautiful.colors.yellow, function()
      awful.spawn("systemctl reboot")
    end),
    mkbutton(beautiful.icons.moon, beautiful.colors.magenta, function()
      awful.spawn("systemctl suspend")
    end),
    mkbutton(beautiful.icons.exit, beautiful.colors.blue, function()
      awesome.quit()
    end),
  })

  ret.popup = awful.popup({
    screen = awful.screen.focused(),
    ontop = true,
    visible = false,
    placement = awful.placement.maximize,
    bg = beautiful.power_screen_bg,
    type = "splash",
    widget = wibox.container.place({
      layout = wibox.layout.fixed.vertical,
      wibox.container.place({
        layout = wibox.layout.fixed.vertical,
        message,
        message_small,
        helpers.ui.vertical_padding(12),
        wibox.container.place(buttons),
      }, "center", "center"),
    }),
  })

  return ret
end

instance = instance or new()
return instance
