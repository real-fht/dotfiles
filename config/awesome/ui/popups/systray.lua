---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.systray'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local gobject = require("gears.object")
local gtable = require("gears.table")
local wibox = require("wibox")
local widgets = require("ui.widgets")

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
  local ret = gobject({})
  gtable.crush(ret, systray, true)

  local systray_widget = wibox.widget({
    widget = wibox.widget.systray,
    base_size = beautiful.systray_icon_size,
    horizontal = true,
  })

  ret.popup = awful.popup({
    screen = awful.screen.focused(),
    ontop = true,
    visible = false,
    shape = helpers.ui.rounded_rect(),
    bg = beautiful.colors.transparent,
    placement = function(c)
      return awful.placement.bottom_right(c, {
        honor_workarea = true,
        margins = { right = beautiful.useless_gap + dpi(27), bottom = beautiful.useless_gap },
      })
    end,
    widget = wibox.widget({
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.container.background,
        bg = beautiful.systray_alt_bg,
        {
          widget = wibox.container.margin,
          margins = beautiful.systray_paddings,
          {
            layout = wibox.layout.align.horizontal,
            widgets.text({ text = "Systray" }),
            nil,
            widgets.button.text.normal({
              font = beautiful.icons.xmark.font,
              text = beautiful.icons.xmark.icon,
              normal_bg = beautiful.colors.transparent,
              normal_fg = beautiful.colors.grey_fg,
              halign = "center",
              valign = "center",
              forced_height = dpi(24),
              forced_width = dpi(24),
              size = 12,
              on_release = function()
                ret:hide()
              end,
            }),
          },
        },
      },
      {
        widget = wibox.container.background,
        bg = beautiful.systray_bg,
        {
          widget = wibox.container.margin,
          margins = beautiful.systray_paddings,
          systray_widget,
        },
      },
    }),
    -- placement = function(c)
    --     return awful.placement.top_left(c, {
    --         honor_workarea = true,
    --         margins = { left = beautiful.useless_gap, top = beautiful.useless_gap },
    --     })
    -- end,
  })
  return ret
end

instance = instance or new()
return instance
