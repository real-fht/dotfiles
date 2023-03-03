---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.volume'
---------------------------------------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
local gshape = require "gears.shape"
local gobject = require "gears.object"
local pulseaudio_daemon = require "daemons.hardware.pulseaudio"
local gtimer = require "gears.timer"
local wibox = require "wibox"
local widgets = require "ui.widgets"
local theme_vars = beautiful.osds.volume

local instance = nil

local function new()
  local ret = gobject {}

  local volume_icon = widgets.button.text.normal {
    text = beautiful.icons.volume_normal.icon,
    font = beautiful.icons.volume_normal.font,
    normal_fg = theme_vars.icon_fg,
    normal_bg = beautiful.colors.transparent,
    hover_effect = false,
    press_effect = false,
    forced_height = dpi(24),
    forced_width = dpi(24),
    halign = "center",
    on_press = function()
      pulseaudio_daemon:sink_toggle_mute()
    end,
  }

  local volume_sink_name = widgets.text {
    halign = "center",
    valign = "center",
    size = 12,
  }

  local volume_slider = wibox.widget {
    widget = wibox.widget.slider,
    handle_shape = gshape.circle,
    handle_color = theme_vars.slider_color,
    handle_width = theme_vars.slider_height + dpi(3),
    forced_width = theme_vars.slider_width,
    forced_height = theme_vars.slider_height + dpi(3),
    bar_height = theme_vars.slider_height,
    shape = helpers.ui.rounded_rect(),
    bar_shape = helpers.ui.rounded_rect(),
    value = 0,
    maximum = 100,
    minumum = 0,
    bar_color = beautiful.colors.oneb3 .. beautiful.opacity_modifier,
    bar_active_color = theme_vars.slider_color,
  }

  volume_slider:connect_signal("property::value", function(_, value, instant)
    if instant == false then
      pulseaudio_daemon:sink_set_volume(nil, value)
    end
  end)

  local hide_timer = gtimer {
    timeout = 1.5,
    callback = function()
      ret.popup.visible = false
    end,
  }

  ret.popup = awful.popup {
    type = "notification",
    screen = awful.screen.focused(),
    visible = false,
    ontop = true,
    placement = function(c)
      return awful.placement.bottom(c, {
        honor_workarea = true,
        margins = { bottom = beautiful.useless_gap },
      })
    end,
    minimum_width = 1,
    minimum_height = 1,
    bg = beautiful.colors.transparent,
    shape = require("gears.shape").rectangle,
    border_width = 0,
    widget = {
      widget = wibox.container.background,
      bg = theme_vars.bg,
      shape = helpers.ui.rounded_rect(),
      halign = "center",
      valign = "center",
      {
        widget = wibox.container.margin,
        margins = theme_vars.paddings,
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(6),
          {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(6),
            volume_icon,
            volume_sink_name,
          },
          volume_slider,
        },
      },
    },
  }

  -- Don't hide the popup when the mouse is hovering it
  ret.popup:connect_signal("mouse::enter", function()
    hide_timer:stop()
  end)
  ret.popup:connect_signal("mouse::leave", function()
    hide_timer:again()
  end)

  local show = false
  pulseaudio_daemon:connect_signal("sinks::default::updated", function(_, device)
    if show == true then
      if device.mute or device.volume == 0 then
        volume_icon:set_text(beautiful.icons.volume_off.icon)
      elseif device.volume <= 33 then
        volume_icon:set_text(beautiful.icons.volume_low.icon)
      elseif device.volume <= 66 then
        volume_icon:set_text(beautiful.icons.volume_normal.icon)
      elseif device.volume > 66 then
        volume_icon:set_text(beautiful.icons.volume_high.icon)
      end

      volume_sink_name:set_text(device.description)
      volume_slider:set_value_instant(device.volume)

      if ret.popup.visible then
        hide_timer:again()
      else
        ret.popup.visible = true
        hide_timer:again()
      end
    else
      volume_slider:set_value_instant(device.volume)
      show = true
    end
  end)

  return ret
end

instance = instance or new()
return instance
