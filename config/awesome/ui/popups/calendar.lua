---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.calendar'
---------------------------------------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
local gobject = require "gears.object"
local gshape = require "gears.shape"
local gtable = require "gears.table"
local wibox = require "wibox"
local widgets = require "ui.widgets"
local theme_vars = beautiful.popups.calendar

local calendar, instance = {}, nil

function calendar:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true

  self:emit_signal("visibility", true)
end

function calendar:hide()
  self.popup.visible = false
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
  local ret = gobject {}
  gtable.crush(ret, calendar, true)

  ret.popup = awful.popup {
    screen = awful.screen.focused(),
    border_width = 0,
    ontop = true,
    visible = false,
    shape = gshape.rectangle,
    bg = beautiful.colors.transparent,
    placement = function(c)
      local placement_fn_name = beautiful.wibar.position .. "_right"
      return awful.placement[placement_fn_name](c, {
        honor_workarea = true,
        margins = {
          right = beautiful.useless_gap,
          [beautiful.wibar.position] = beautiful.useless_gap,
        },
      })
    end,
    widget = wibox.widget {
      widget = wibox.container.background,
      bg = theme_vars.bg,
      maximum_height = dpi(128),
      forced_width = dpi(312),
      {
        widget = wibox.container.margin,
        margins = theme_vars.paddings,
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(12),
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
          widgets.separator {
            orientation = "horizontal",
            thickness = dpi(1),
            forced_height = dpi(1),
            forced_width = dpi(1),
          },
          -- },
          wibox.container.place(widgets.calendar()),
        },
      },
    },
  }

  helpers.ui.hide_on_outside_click(ret)
  helpers.ui.hide_on_tag_change(ret)

  return ret
end

instance = instance or new()
return instance
