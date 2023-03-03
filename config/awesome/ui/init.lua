---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui'
---Making AwesomeWM pretty and aethestic using it's widget framework
---------------------------------------------------------------------------------

require "ui.decorations"
require "ui.notifications"
require "ui.wibar"

-- Initialize popups.
local calendar_popup = require "ui.popups.calendar"
local layout_picker = require "ui.popups.layout-picker"
local systray_popup = require "ui.popups.systray"
require "ui.popups.main-menu"
require "ui.popups.tag-preview"

-- Initialize OSDs.
require "ui.popups.osds.volume"

-- Initialize applets.
local audio_applet = require "ui.applets.audio"
local wifi_applet = require "ui.applets.wifi"

-- Initialize screens.
local power_screen = require "ui.screens.power"

-- Initialize panels.
local info_panel = require "ui.panels.info"

calendar_popup:connect_signal("visibility", function(_, state)
  if state == true then
    systray_popup:hide()
    audio_applet:hide()
    info_panel:hide()
  end
end)

systray_popup:connect_signal("visibility", function(_, state)
  if state == true then
    calendar_popup:hide()
    audio_applet:hide()
    info_panel:hide()
  end
end)

audio_applet:connect_signal("visibility", function(_, state)
  if state == true then
    calendar_popup:hide()
    systray_popup:hide()
    -- info_panel:hide()
  end
end)

power_screen:connect_signal("visibility", function(_, state)
  if state == true then
    calendar_popup:hide()
    systray_popup:hide()
    layout_picker:hide()
    info_panel:hide()
  end
end)

info_panel:connect_signal("visibility", function(_, state)
  if state == true then
    calendar_popup:hide()
    systray_popup:hide()
  else
    audio_applet:hide()
    wifi_applet:hide()
    -- bluetooth_applet:hide()
  end
end)
