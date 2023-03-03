---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets'
---Generic widgets that are used throughout the configuration
---------------------------------------------------------------------------------

local button = require "ui.widgets.button"
local calendar = require "ui.widgets.calendar"
local container = require "ui.widgets.container"
local menu = require "ui.widgets.menu"
local prompt = require "ui.widgets.prompt"
-- local icons = require 'ui.widgets.icons'
local separator = require "ui.widgets.separator"
local spinning_circle = require "ui.widgets.spinning-circle"
local screen_mask = require "ui.widgets.screen-mask"
local text = require "ui.widgets.text"

return {
  button = button,
  calendar = calendar,
  container = container,
  menu = menu,
  prompt = prompt,
  -- icons = icons,
  separator = separator,
  spinning_circle = spinning_circle,
  screen_mask = screen_mask,
  text = text,
}
