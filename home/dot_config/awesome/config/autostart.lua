---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.autostart'
---Autostarting daemons, services, and other miscellaneous stuff
---------------------------------------------------------------------------------

local awful = require("awful")
local helpers = require("helpers")

-- Compositing (window effects, shadows, etc)
-- Preferrably use dsccillag's or pijulius' picom forks.
awful.spawn.once("picom")

-- Sound server, make sure to emerge media-video/pipewire with sound-server flag.
-- Also launching it here since DBUS_SESSION_BUS_ADDRESS *has* to be set for pw to
-- worrk.
awful.spawn.once("gentoo-pipewire-launcher")
