---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.applets.network'
---------------------------------------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gobject = require "gears.object"
local gshape = require "gears.shape"
local gtable = require "gears.table"
local helpers = require "helpers"
local wibox = require "wibox"
local widgets = require "ui.widgets"
-- -*-
local network_daemon = require "daemons.hardware.network"

local applet, instance = {}, nil

function applet:show(next_to)
  self.popup.screen = awful.screen.focused()
  self.popup:move_next_to(next_to)
  self.popup.visible = true
  self:emit_signal("visibility", true)
end

function applet:hide()
  self.popup.visible = false
  self:emit_signal("visibility", false)
end

function applet:toggle(next_to)
  if self.popup.visible then
    self:hide()
  else
    self:show(next_to)
  end
end

local function access_point_widget(layout, access_point)
  local widget = nil

  local wifi_icon = widgets.text {
    font = beautiful.icons.wifi_high.font,
    color = beautiful.accent,
    height = dpi(45),
    width = dpi(45),
    size = 20,
    text = access_point.strength > 66 and beautiful.icons.wifi_high.icon
      or access_point.strength > 33 and beautiful.icons.wifi_medium.icon
      or beautiful.icons.wifi_low.icon,
  }

  local name = widgets.text {
    width = dpi(500),
    height = dpi(45),
    halign = "left",
    valign = "center",
    size = 12,
    text = network_daemon:is_access_point_active(access_point) and access_point.ssid .. " - Activated"
      or access_point.ssid,
    color = beautiful.colors.white,
  }

  local prompt =
    widgets.prompt {
      forced_width = dpi(500) - beautiful.applets.wifi.paddings * 2 - beautiful.applets.wifi.item_paddings * 2 - dpi(
        40
      ) - dpi(8),
      obscure = true,
      text = access_point.password,
      icon_color = beautiful.accent,
      icon_font = beautiful.icons.lock.font,
      icon = beautiful.icons.lock.icon,
      normal_bg = beautiful.colors.transparent,
      on_normal_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
      forced_height = dpi(40),
      paddings = { left = beautiful.applets.wifi.item_paddings, right = beautiful.applets.wifi.item_paddings },
      on_return_callback = function(self)
        -- Try to connect to the network when hitting return
        if network_daemon:is_access_point_active(access_point) == false then
          network_daemon:connect_to_access_point(access_point, self:get_text(), false)
        end
      end,
    }

  local toggle_password_button = widgets.button.text.state {
    on_by_default = true,
    forced_height = dpi(40),
    forced_width = dpi(40),
    size = 12,
    halign = "center",
    text = beautiful.icons.toggle_off.icon,
    on_text = beautiful.icons.toggle_on.icon,
    font = beautiful.icons.toggle_on.font,
    normal_fg = beautiful.accent,
    normal_bg = beautiful.colors.transparent,
    on_normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
    on_hover_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
    on_press = function()
      prompt:stop()
    end,
    on_turn_on = function()
      prompt:set_obscure(true)
    end,
    on_turn_off = function()
      prompt:set_obscure(false)
    end,
  }

  local cancel = widgets.button.text.normal {
    normal_fg = beautiful.colors.white,
    normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
    forced_height = dpi(40),
    forced_width = dpi(250),
    size = 12,
    halign = "center",
    text = "Cancel",
    on_press = function()
      prompt:stop()
      widget:turn_off()
      widget:set_height(dpi(45))
    end,
  }

  local connect_or_disconnect = widgets.button.text.normal {
    normal_fg = beautiful.colors.white,
    normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
    forced_height = dpi(40),
    forced_width = dpi(250),
    size = 12,
    halign = "center",
    text = network_daemon:is_access_point_active(access_point) == true and "Disconnect" or "Connect",
    on_press = function()
      network_daemon:toggle_access_point(access_point, prompt:get_text(), false)
    end,
  }

  network_daemon:connect_signal(access_point.hw_address .. "::state", function(self, new_state, old_state)
    name:set_text(access_point.ssid .. " - " .. network_daemon.device_state_to_string(new_state))

    if new_state == network_daemon.DeviceState.PREPARE or new_state == network_daemon.DeviceState.CONNECTING then
      connect_or_disconnect:set_text "Connecting..."
    elseif new_state == network_daemon.DeviceState.ACTIVATED then
      layout:remove_widgets(widget)
      layout:insert(1, widget)
      connect_or_disconnect:set_text "Disconnect"
      -- -*-
      prompt:stop()
      widget:turn_off()
      widget:set_height(dpi(45))
    elseif
      new_state == network_daemon.DeviceState.DISCONNECTED
      or new_state == network_daemon.DeviceState.DISCONNECTING
      or new_state == network_daemon.DeviceState.NEED_AUTH
      or new_state == network_daemon.DeviceState.FAILED
      or not new_state == new_state.DeviceState.ACTIVATED
    then
      prompt:stop()
      connect_or_disconnect:set_text "Connect"
    end
  end)

  network_daemon:connect_signal("activate_access_point::failed", function()
    prompt:stop()
    connect_or_disconnect:set_text "Connect"
  end)

  widget = widgets.button.basic.state {
    normal_bg = beautiful.colors.transparent,
    on_normal_bg = beautiful.colors.black2,
    press_effect = false,
    forced_height = dpi(45),
    on_press = function(self)
      if self._private.state == false then
        awesome.emit_signal("access_point_widget::expanded", widget)
        prompt:start()
        self:set_height(dpi(45) + dpi(40) + dpi(40) + (dpi(8) * 3))
        self:turn_on()
      end
    end,
    child = {
      widget = wibox.container.margin,
      margins = beautiful.applets.wifi.item_paddings,
      {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(8),
        {
          layout = wibox.layout.fixed.horizontal,
          forced_width = dpi(500),
          forced_height = dpi(45),
          spacing = dpi(8),
          wifi_icon,
          name,
        },
        {
          layout = wibox.layout.fixed.horizontal,
          forced_width = dpi(500),
          forced_height = dpi(40),
          spacing = dpi(8),
          prompt.widget,
          toggle_password_button,
        },
        {
          layout = wibox.layout.flex.horizontal,
          spacing = dpi(8),
          forced_height = dpi(40),
          forced_width = dpi(500),
          connect_or_disconnect,
          cancel,
        },
      },
    },
  }

  awesome.connect_signal("access_point_widget::expanded", function(toggled_on_widget)
    if toggled_on_widget ~= widget then
      prompt:stop()
      widget:turn_off()
      widget:set_height(dpi(45))
    end
  end)

  return widget
end

local function content(self)
  local header = widgets.text {
    text = "Wi-Fi",
    halign = "left",
    size = 14,
    bold = true,
    color = beautiful.accent,
  }

  local rescan = widgets.button.text.normal {
    normal_fg = beautiful.accent,
    font = beautiful.icons.arrow_rotate_right.font,
    text = beautiful.icons.arrow_rotate_right.icon,
    forced_width = dpi(28),
    forced_height = dpi(28),
    halign = "center",
    on_press = function()
      network_daemon:scan_access_points()
    end,
  }

  local close = widgets.button.text.normal {
    normal_fg = beautiful.accent,
    font = beautiful.icons.xmark.font,
    text = beautiful.icons.xmark.icon,
    forced_width = dpi(28),
    forced_height = dpi(28),
    halign = "center",
    on_press = function()
      self:hide()
    end,
  }

  local networks_layout = wibox.widget {
    layout = require("wibox.layout.overflow").vertical,
    forced_height = dpi(500),
    spacing = beautiful.applets.wifi.item_spacing,
    scrollbar_widget = {
      widget = wibox.widget.separator,
      color = beautiful.colors.onebg,
      shape = helpers.ui.rounded_rect(),
    },
    scrollbar_width = dpi(10),
    step = 50,
  }

  local no_wifi = wibox.container.place {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(12),
    widgets.text {
      color = beautiful.colors.grey,
      halign = "center",
      size = 75,
      font = beautiful.icons.wifi_off.font,
      text = beautiful.icons.wifi_off.icon,
    },
    widgets.text {
      color = beautiful.colors.grey,
      halign = "center",
      size = 12,
      text = "Well, the Wi-Fi isn't activated for the moment...",
    },
  }

  local stack = wibox.widget {
    layout = wibox.layout.stack,
    top_only = true,
    networks_layout,
    no_wifi,
  }

  network_daemon:connect_signal("wireless_state", function(_, state)
    if state == false then
      stack:raise_widget(no_wifi)
    else
      stack:raise_widget(networks_layout)
    end
  end)

  network_daemon:connect_signal("scan_access_points::success", function(_, access_points)
    networks_layout:reset()
    for _, access_point in pairs(access_points) do
      if network_daemon:is_access_point_active(access_point) then
        networks_layout:insert(1, access_point_widget(networks_layout, access_point))
      else
        networks_layout:add(access_point_widget(networks_layout, access_point))
      end
    end
    stack:raise_widget(networks_layout)
  end)

  return wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(8),
    {
      layout = wibox.layout.align.horizontal,
      header,
      nil,
      wibox.layout.fixed.horizontal(rescan, close),
    },
    widgets.separator {
      orientation = "horizontal",
      forced_height = dpi(2),
    },
    stack,
  }
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, applet, true)

  ret.popup = awful.popup {
    bg = beautiful.colors.transparent,
    shape = gshape.rectangle,
    ontop = true,
    visible = false,
    minimum_width = dpi(500),
    maximum_width = dpi(500),
    forced_height = dpi(12),
    -- placement = function(c)
    --   awful.placement.bottom_right(c, {
    --     honor_workarea = true,
    --     margins = { right = beautiful.useless_gap, bottom = beautiful.useless_gap },
    --   })
    -- end,
    widget = wibox.widget {
      widget = wibox.container.background,
      bg = beautiful.applets.wifi.bg,
      {
        widget = wibox.container.margin,
        margins = beautiful.applets.wifi.paddings,
        content(ret),
      },
    },
  }

  return ret
end

instance = instance or new()
return instance
