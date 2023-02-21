---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.wallpaper'
---------------------------------------------------------------------------------

-- NOTE: This is now managed by nixos automatically at X server startup.

local beautiful = require("beautiful")
local wallpaper = require("modules.bling.module.wallpaper")

-- Lazy wallpaper setup using Bling!
wallpaper.setup({
  wallpaper = beautiful.wallpaper,
  position = "maximized",
  scale = 1,
})
