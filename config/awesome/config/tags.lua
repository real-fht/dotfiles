---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.tags'
---Configuration and setting up for AwesomeWM's tags, not workspaces
---------------------------------------------------------------------------------

local awful = require "awful"
local Layout = awful.layout.suit
local capi = { screen = screen, tag = tag } -- luacheck: ignore

capi.tag.connect_signal("request::default_layouts", function()
  -- Initialize tag layouts
  awful.layout.append_default_layouts {
    Layout.tile,
    Layout.floating,
    Layout.tile.left,
    Layout.tile.bottom,
    Layout.tile.top,
    Layout.fair,
    Layout.fair.horizontal,
    Layout.spiral,
    Layout.spiral.dwindle,
    Layout.max,
    Layout.max.fullscreen,
    Layout.magnifier,
    Layout.corner.nw,
    Layout.corner.ne,
    Layout.corner.sw,
    Layout.corner.se,
  }
end)

capi.screen.connect_signal("request::desktop_decoration", function(s)
  -- Initialize 9 different tags with tile layout as the default
  awful.tag({ "1", "2", "3", "4", "5", "6" }, s, Layout.tile)
end)
