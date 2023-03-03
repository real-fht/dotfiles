---------------------------------------------------------------------------------
----@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
----@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
----@module 'helpers.ui'
---------------------------------------------------------------------------------

local M = {}

local awful = require "awful"
local beautiful = require "beautiful"
local gshape = require "gears.shape"
local gmatrix = require "gears.matrix"
local wibox = require "wibox"
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
  return wibox.widget { widget = wibox.widget.place, forced_height = size }
end

---Create a empty horizontal padding of given size
---@param size
function M.horizontal_padding(size)
  return wibox.widget { widget = wibox.widget.place, forced_width = size }
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

local function _get_widget_geometry(_hierarchy, widget)
  local width, height = _hierarchy:get_size()
  if _hierarchy:get_widget() == widget then
    -- Get the extents of this widget in the device space
    local x, y, w, h = gmatrix.transform_rectangle(_hierarchy:get_matrix_to_device(), 0, 0, width, height)
    return { x = x, y = y, width = w, height = h, hierarchy = _hierarchy }
  end

  for _, child in ipairs(_hierarchy:get_children()) do
    local ret = _get_widget_geometry(child, widget)
    if ret then
      return ret
    end
  end
end

function M.get_widget_geometry(wibox, widget)
  return _get_widget_geometry(wibox._drawable._widget_hierarchy, widget)
end

function M.hide_on_outside_click(self)
  awful.mouse.append_client_mousebinding(awful.button({ "Any" }, 1, function()
    self:hide(true)
  end))
  -- -*-
  awful.mouse.append_client_mousebinding(awful.button({ "Any" }, 3, function()
    self:hide(true)
  end))
  -- And hide the menu when clicking on the root window
  awful.mouse.append_global_mousebinding(awful.button({ "Any" }, 1, function()
    self:hide(true)
  end))
  -- -*-
  awful.mouse.append_global_mousebinding(awful.button({ "Any" }, 3, function()
    self:hide(true)
  end))
end

function M.hide_on_tag_change(self)
  -- Hide when changing tags
  tag.connect_signal("property::selected", function()
    self:hide()
  end)
end

return M
