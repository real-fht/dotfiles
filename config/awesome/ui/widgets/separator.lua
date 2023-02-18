---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.separator'
---------------------------------------------------------------------------------

local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gshape = require("gears.shape")
local wibox = require("wibox")

---@class WidgetsSeparatorArgs
---@field color string?
---@field orientation 'vertical'|'horizontal'?
---@field shape any?
---@field thickness number?
---@field halign HorizontalAlignement?
---@field valign VerticalAlignement?

---@param args WidgetsSeparatorArgs?
---@return WidgetsSeparatorArgs
local function ensure_args(args)
  args = args or {}

  args.orientation = args.orientation or "horizontal"
  args.color = args.color or beautiful.colors.oneb2
  args.shape = args.shape or gshape.rounded_bar
  args.thickness = args.thickness or dpi(2)
  args.halign = args.halign or "center"
  args.valign = args.valign or "center"

  return args
end

---@param args WidgetsSeparatorArgs
return function(args)
  args = ensure_args(args)

  return wibox.widget({
    color = args.color,
    forced_height = args.orientation == "vertical" and dpi(1) or dpi(2),
    forced_width = args.orientation == "vertical" and dpi(2) or dpi(1),
    halign = args.halign,
    orientation = args.orientation,
    shape = args.shape,
    thickness = args.thickness,
    valign = args.valign,
    widget = wibox.widget.separator,
  })
end
