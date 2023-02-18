---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.autostart'
---Autostarting daemons, services, and other miscellaneous stuff
---------------------------------------------------------------------------------

-- local awful = require 'awful'
-- local helpers = require 'helpers'

-- Compositing (window effects, shadows, etc)
-- Preferrably use dsccillag's or pijulius' picom forks.
-- helpers.spawn.exec_unless_ps('picom', function()
--     awful.spawn 'picom --backend=xrender'
-- end)

-- Sound server, make sure to emerge media-video/pipewire with sound-server flag.
-- helpers.spawn.exec_unless_ps('pipewire', function()
--     awful.spawn 'dbus-launch gentoo-pipewire-launcher'
-- end)

-- Music daemon.
-- helpers.spawn.exec_unless_ps('mpd', function()
--     -- Included with dotfiles
--     awful.spawn '~/.local/bin/launch-mpd'
-- end)
