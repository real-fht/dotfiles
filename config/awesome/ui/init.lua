---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui'
---Making AwesomeWM pretty and aethestic using it's widget framework
---------------------------------------------------------------------------------

require("ui.decorations")
require("ui.notifications")
require("ui.wibar")

-- Initialize popups.
local calendar_popup = require("ui.popups.calendar")
local layout_picker = require("ui.popups.layout-picker")
local systray_popup = require("ui.popups.systray")
local main_menu = require("ui.popups.main-menu")
require("ui.popups.tag-preview")
-- Initialize screens.
local power_screen = require("ui.screens.power")

calendar_popup:connect_signal("visibility", function(_, state)
  if state == true then
    systray_popup:hide()
  end
end)

systray_popup:connect_signal("visibility", function(_, state)
  if state == true then
    calendar_popup:hide()
  end
end)

power_screen:connect_signal("visibility", function(_, state)
  if state == true then
    calendar_popup:hide()
    systray_popup:hide()
    layout_picker:hide()
  end
end)
