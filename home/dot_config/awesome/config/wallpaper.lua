---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.wallpaper'
---------------------------------------------------------------------------------

local beautiful = require("beautiful")
local wallpaper = require("modules.bling.module.wallpaper")

-- Lazy wallpaper setup using Bling!
wallpaper.setup({
  wallpaper = beautiful.wallpaper,
  position = "maximized",
  scale = 1,
})
