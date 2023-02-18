---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.container'
---------------------------------------------------------------------------------

local beautiful = require("beautiful")
local wibox = require("wibox")
local gtable = require("gears.table")
local helpers = require("helpers")

local container = { mt = {} }

---Changes the background color of the container
---@param bg string
function container:set_bg(bg)
  self:get_children_by_id("background_role")[1].bg = bg
end

---Changes the border color of the container
---@param border_color string
function container:set_border_color(border_color)
  self:get_children_by_id("background_role")[1].border_color = border_color
end

---Changes the border color of the container
---@param border_width number
function container:set_border_width(border_width)
  self:get_children_by_id("background_role")[1].border_width = border_width
end

---Changes the margins of the container
---@param margins number
function container:set_margins(margins)
  self.get_children_by_id("margin_role")[1].margins = margins
end

---Changes the paddings of the container
---@param paddings number
function container:set_paddings(paddings)
  self:get_children_by_id("padding_role")[1].margins = paddings
end

---Changes the width of the container
---@param width number
function container:set_width(width)
  self:get_children_by_id("background_role")[1].forced_width = width
end

---Changes the height of the container
---@param height number
function container:set_height(height)
  self:get_children_by_id("background_role")[1].forced_height = height
end

---@class ContainerArgs
---@field child               table?
---@field bg                  string?
---@field fg                  string?
---@field shape               any?
---@field border_width        number?
---@field border_color        string?
---@field border_strategy     string?
---@field forced_height       number?
---@field forced_width        number?
---@field maximum_width       number?
---@field maximum_height      number?
---@field opacity             integer?
---@field constraint_strategy string?
---@field constraint_height   number?
---@field constraint_width    number?
---@field margins             number?
---@field paddings            number?
---@field valign              "top"|"bottom"|"center"?
---@field halign              "left"|"right"|"center"?
---@field direction           "north"|"south"|"east"|"west"?

---Creates a new conatainer.
---@param args ContainerArgs
local function new(args)
    -- stylua: ignore start
    args                     = args or {}
    args.child               = args.child or nil
    -- -*- wibox.container.background
    args.bg                  = args.bg or nil
    args.fg                  = args.fg or nil
    args.shape               = args.shape or helpers.ui.rounded_rect(beautiful.corner_radius)
    args.border_width        = args.border_width or 0
    args.border_color        = args.border_color or beautiful.colors.transparent
    args.border_strategy     = args.border_color or nil
    args.forced_height       = args.forced_height or nil
    args.forced_width        = args.forced_width or nil
    args.maximum_width       = args.maximum_width or nil
    args.maximum_height      = args.maximum_height or nil
    args.opacity             = args.opacity or nil
    -- -*- wibox.container.constraint
    args.constraint_strategy = args.constraint_strategy or nil
    args.constraint_height   = args.constraint_height or nil
    args.constraint_width    = args.constraint_width or nil
    -- -*- wibox.container.margin
    args.margins             = args.margins or 0
    args.paddings            = args.paddings or nil
    -- -*- wibox.container.place
    args.valign              = args.valign or nil
    args.halign              = args.halign or nil
    -- -*- wibox.container.rotate
    args.direction           = args.direction or nil
  -- stylua: ignore end

  local widget = wibox.widget({
    widget = wibox.container.rotate,
    id = "rotate_role",
    direction = args.direction,
    {
      widget = wibox.container.constraint,
      id = "constraint_role",
      strategy = args.constraint_strategy,
      height = args.constraint_height,
      width = args.constraint_width,
      {
        widget = wibox.container.place,
        id = "place_role",
        valign = args.valign,
        halign = args.halign,
        {
          widget = wibox.container.margin,
          id = "margin_role",
          margins = args.margins,
          {
            widget = wibox.container.background,
            id = "background_role",
            bg = args.bg,
            fg = args.fg,
            shape = args.shape,
            border_width = args.border_width,
            border_color = args.border_color,
            border_strategy = args.border_color,
            forced_height = args.forced_height,
            forced_width = args.forced_width,
            maximum_height = args.maximum_height,
            maximum_width = args.maximum_width,
            opacity = args.opacity,
            {
              widget = wibox.container.margin,
              id = "padding_role",
              margins = args.paddings,
              args.child,
            },
          },
        },
      },
    },
  })

  gtable.crush(widget, container, true)

  return widget
end

function container.mt:__call(...)
  return new(...)
end

return setmetatable(container, container.mt)
