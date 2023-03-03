---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.notifications.upower'
---------------------------------------------------------------------------------

local beautiful = require "beautiful"
local upower_daemon = require "daemons.hardware.upower"
local naughty = require "naughty"

local UPower_DeviceState = {
  Unknown = 0,
  Charging = 1,
  Discharging = 2,
  Empty = 3,
  Fully_charged = 4,
  Pending_charge = 5,
  Pending_discharge = 6,
}

-- To not display one billion notifications, save and compare the battery device state.
local display_charging, display_full, display_low = true, true, true

upower_daemon:connect_signal("battery::update", function(_, device)
  -- {{{Charging notification
  if display_charging and device.State == UPower_DeviceState.Charging then
    naughty.notification {
      app_name = "UPower",
      app_font_icon = beautiful.icons.car_battery,
      font_icon = beautiful.icons.battery_bolt,
      title = "Battery Status",
      timeout = 3,
      text = string.format("Charging! (Currently at %d%%)", device.Percentage),
    }
    display_charging = false
  end
  --}}}

  --{{{Full charge notification
  if display_full and device.State == UPower_DeviceState.Fully_charged then
    naughty.notification {
      app_name = "UPower",
      app_font_icon = beautiful.icons.car_battery,
      font_icon = beautiful.icons.battery_full,
      title = "Battery Status",
      timeout = 3,
      text = "Fully Charged!",
    }
    display_full = false
  end
  --}}}

  --{{{Full charge notification
  if display_low and device.State == UPower_DeviceState.Discharging and device.Percentage <= 20 then
    naughty.notification {
      app_name = "UPower",
      app_font_icon = beautiful.icons.car_battery,
      font_icon = beautiful.icons.battery_full,
      urgency = "critical",
      timeout = 3,
      title = "Battery Status",
      text = string.format("Running low on battery\n(%d%% remaining!)", device.Percentage),
    }
    display_low = false
  end
  --}}}

  display_charging = device.State == UPower_DeviceState.Discharging
  display_full = device.State ~= UPower_DeviceState.Fully_charged
  display_low = device.Percentage <= 23
end)

-- vim: foldmethod=marker
