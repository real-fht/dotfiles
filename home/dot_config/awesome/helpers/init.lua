---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'helpers'
---Utility functions used throughout the config
---------------------------------------------------------------------------------

local client = require("helpers.client")
local color = require("helpers.color")
local ui = require("helpers.ui")

return {
  client = client,
  color = color,
  ui = ui,
}
