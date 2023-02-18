---------------------------------------------------------------------------------
----@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
----@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
----@module 'helpers.ui'
---------------------------------------------------------------------------------

local M = {}

local beautiful = require("beautiful")
local gshape = require("gears.shape")
local wibox = require("wibox")
local capi = { mouse = mouse } -- luacheck: ignore

---Generate markup for given text
---@param text string
---@param settings table
function M.generate_markup(text, settings)
  settings = settings or {} -- Defaults, just in case

  local bold_start = settings.bold and "<b>" or ""
  local bold_end = settings.bold and "</b>" or ""
  local italic_start = settings.italic and "<i>" or ""
  local italic_end = settings.italic and "</i>" or ""
  local colorized_text =
    string.format([[<span foreground='%s'>%s</span>]], settings.color or beautiful.colors.white, tostring(text))

  return string.format("%s%s%s%s%s", bold_start, italic_start, colorized_text, italic_end, bold_end)
end

----Create a rounded rectangle based on given radius.
----@param radius number
function M.rounded_rect(corner_radius)
  corner_radius = corner_radius or beautiful.corner_radius
  return function(cairo_object, width, height)
    return gshape.rounded_rect(cairo_object, width, height, corner_radius)
  end
end

---Create a empty vertical padding of given size
---@param size number
function M.vertical_padding(size)
  return wibox.widget({ widget = wibox.widget.place, forced_height = size })
end

---Create a empty horizontal padding of given size
---@param size
function M.horizontal_padding(size)
  return wibox.widget({ widget = wibox.widget.place, forced_width = size })
end

---Add a hover cursor effect on a given widget.
function M.add_hover_cursor(w)
  local original_cursor = "left_ptr"

  w:connect_signal("mouse::enter", function()
    local widget = capi.mouse.current_wibox
    if widget then
      widget.cursor = "hand2"
    end
  end)

  w:connect_signal("mouse::leave", function()
    local widget = capi.mouse.current_wibox
    if widget then
      widget.cursor = original_cursor
    end
  end)
end

return M
