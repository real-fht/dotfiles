---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'daemons.hardware.upower'
---------------------------------------------------------------------------------

-- Custom implementation of UPower's dbus api using signals.

local dbus_proxy = require "modules.dbus_proxy"
local gobject = require "gears.object"
local gtable = require "gears.table"
local gtimer = require "gears.timer"

local upower, instance = {}, nil

function upower:get_device(path)
  local battery, battery_props
  if path ~= nil and path ~= "" then
    battery = dbus_proxy.Proxy:new {
      bus = dbus_proxy.Bus.SYSTEM,
      name = "org.freedesktop.UPower",
      interface = "org.freedesktop.UPower.Device",
      path = path,
    }
    battery_props = dbus_proxy.Proxy:new {
      bus = dbus_proxy.Bus.SYSTEM,
      name = "org.freedesktop.UPower",
      interface = "org.freedesktop.DBus.Properties",
      path = path,
    }
  else
    battery = dbus_proxy.Proxy:new {
      bus = dbus_proxy.Bus.SYSTEM,
      name = "org.freedesktop.UPower",
      interface = "org.freedesktop.UPower.Device",
      path = self.UPower:GetDisplayDevice(),
    }
    battery_props = dbus_proxy.Proxy:new {
      bus = dbus_proxy.Bus.SYSTEM,
      name = "org.freedesktop.UPower",
      interface = "org.freedesktop.DBus.Properties",
      path = self.UPower:GetDisplayDevice(),
    }
  end

  return battery, battery_props
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, upower, true)

  ret.UPower = dbus_proxy.Proxy:new {
    bus = dbus_proxy.Bus.SYSTEM,
    name = "org.freedesktop.UPower",
    interface = "org.freedesktop.UPower",
    path = "/org/freedesktop/UPower",
  }

  -- Initiate a new battery interface.
  local battery, battery_props = ret:get_device "/org/freedesktop/UPower/devices/battery_BAT1"
  ret.battery, ret.battery_props = battery, battery_props

  -- Connect signals.
  ret.battery_props:connect_signal(function()
    ret:emit_signal("battery::update", battery)
  end, "PropertiesChanged")

  -- Initial update to setup widgets.
  gtimer.delayed_call(ret.emit_signal, ret, "battery::update", battery)

  return ret
end

instance = instance or new()
return instance
