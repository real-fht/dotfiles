---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.calendar'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local gobject = require("gears.object")
local gshape = require("gears.shape")
local gtable = require("gears.table")
local wibox = require("wibox")
local widgets = require("ui.widgets")

local calendar, instance = {}, nil

function calendar:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true

  self.keygrabber = awful.keygrabber({
    keypressed_callback = function(_, _, key, _) --luacheck: ignore
      if key == "q" or key == "Escape" then
        self:hide()
      end
    end,
  })
  self.keygrabber:start()

  self:emit_signal("visibility", true)
end

function calendar:hide()
  self.popup.visible = false
  pcall(self.keygrabber.stop, self.keygrabber)
  self:emit_signal("visibility", false)
end

function calendar:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function new()
  local ret = gobject({})
  gtable.crush(ret, calendar, true)
  ret.keygrabber = nil

  ret.popup = awful.popup({
    screen = awful.screen.focused(),
    border_width = 0,
    ontop = true,
    visible = false,
    shape = gshape.rectangle,
    placement = function(c)
      return awful.placement.bottom_right(c, {
        honor_workarea = true,
        margins = { right = beautiful.useless_gap, bottom = beautiful.useless_gap },
      })
    end,
    widget = wibox.widget({
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.container.background,
        bg = beautiful.calendar_alt_bg,
        maximum_height = dpi(128),
        forced_width = dpi(256),
        {
          widget = wibox.container.margin,
          margins = beautiful.calendar_paddings,
          {
            layout = wibox.layout.fixed.vertical,
            {
              widget = wibox.widget.textclock,
              font = beautiful.font_name .. " 20",
              halign = "center",
              format = string.format(
                "%s%s%s",
                helpers.ui.generate_markup("%H", { color = beautiful.colors.white }),
                helpers.ui.generate_markup(":", { color = beautiful.accent, bold = true }),
                helpers.ui.generate_markup("%M", { color = beautiful.colors.white })
              ),
            },
            {
              widget = wibox.widget.textclock,
              font = beautiful.font_name .. " 14",
              halign = "center",
              format = helpers.ui.generate_markup("%A %d %B, %Y", { color = beautiful.colors.grey }),
            },
          },
        },
      },
      {
        widget = wibox.container.background,
        bg = beautiful.calendar_bg,
        {
          widget = wibox.container.margin,
          margins = beautiful.calendar_paddings,
          wibox.container.place(widgets.calendar()),
        },
      },
    }),
  })

  return ret
end

instance = instance or new()
return instance
