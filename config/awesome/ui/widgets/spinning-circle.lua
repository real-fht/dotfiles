---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.spinning-circle'
---------------------------------------------------------------------------------

local animation = require "modules.animation"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gtable = require "gears.table"
local setmetatable = setmetatable
local wibox = require "wibox"

local spinning_circle = { mt = {} }

function spinning_circle:start()
  self._private.anim:start()
end

function spinning_circle:abort()
  self._private.anim:stop()
end

local function new(args)
  args = args or {}

  args.forced_width = args.forced_width or nil
  args.forced_height = args.forced_height or nil
  args.thickness = args.thickness or dpi(30)
  args.start_by_default = args.start_by_default == nil and false or args.start_by_default

  local widget = wibox.widget {
    widget = wibox.container.arcchart,
    forced_width = dpi(12),
    forced_height = dpi(12),
    max_value = 100,
    min_value = 0,
    value = 30,
    thickness = args.thickness,
    rounded_edge = true,
    colors = {
      {
        type = "linear",
        from = { 0, 0 },
        to = { 400, 400 },
        stops = { { 0, beautiful.accent }, { 0.8, beautiful.accent } },
      },
    },
  }
  gtable.crush(widget, spinning_circle, true)

  widget._private.anim = animation:new {
    target = 100,
    duration = 10,
    easing = animation.easing.linear,
    loop = true,
    update = function(self, pos)
      widget.value = pos
    end,
  }

  if args.start_by_default then
    widget._private.anim:start()
  end

  return widget
end

return setmetatable(spinning_circle, { __call = new })
