---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets'
---Generic widgets that are used throughout the configuration
---------------------------------------------------------------------------------

local button = require("ui.widgets.button")
local calendar = require("ui.widgets.calendar")
local container = require("ui.widgets.container")
-- local icons = require 'ui.widgets.icons'
local separator = require("ui.widgets.separator")
local screen_mask = require("ui.widgets.screen-mask")
local text = require("ui.widgets.text")

return {
  button = button,
  calendar = calendar,
  container = container,
  -- icons = icons,
  separator = separator,
  screen_mask = screen_mask,
  text = text,
}
