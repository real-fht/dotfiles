---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.systray'
---------------------------------------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
local gobject = require "gears.object"
local gtable = require "gears.table"
local wibox = require "wibox"
local widgets = require "ui.widgets"
local theme_vars = beautiful.popups.systray

local systray, instance = {}, nil

function systray:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true
  self:emit_signal("visibility", true)
end

function systray:hide()
  self.popup.visible = false
  self:emit_signal("visibility", false)
end

function systray:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, systray, true)

  local systray_widget = wibox.widget {
    widget = wibox.widget.systray,
    base_size = theme_vars.icon_size,
    horizontal = true,
  }

  ret.popup = awful.popup {
    screen = awful.screen.focused(),
    ontop = true,
    visible = false,
    shape = helpers.ui.rounded_rect(),
    bg = beautiful.colors.transparent,
    placement = function(c)
      local placement_fn_name = beautiful.wibar.position .. "_right"
      return awful.placement[placement_fn_name](c, {
        honor_workarea = true,
        margins = {
          right = beautiful.useless_gap + dpi(27),
          [beautiful.wibar.position] = beautiful.useless_gap,
        },
      })
    end,
    widget = wibox.widget {
      widget = wibox.container.background,
      bg = theme_vars.bg,
      {
        widget = wibox.container.margin,
        margins = theme_vars.paddings,
        systray_widget,
      },
    },
  }

  helpers.ui.hide_on_outside_click(ret)
  helpers.ui.hide_on_tag_change(ret)

  return ret
end

instance = instance or new()
return instance
