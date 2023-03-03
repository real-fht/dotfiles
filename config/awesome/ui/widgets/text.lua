---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.text'
---------------------------------------------------------------------------------

local beautiful = require "beautiful"
local gtable = require "gears.table"
local gstring = require "gears.string"
local wibox = require "wibox"

local text = { mt = {} }

local function generate_markup(self)
  -- NOTE: Adapted from helpers.ui
  local bold, italic = self._private.bold, self._private.italic

  local bold_start = bold and "<b>" or ""
  local bold_end = bold and "</b>" or ""
  local italic_start = italic and "<i>" or ""
  local italic_end = italic and "</i>" or ""

  -- Remove any precedent Pango markup to it doesn't collide with what we already have
  self._private.text = gstring.xml_unescape(self._private.text)
  self._private.text = gstring.xml_escape(self._private.text)

  local colorized_text = string.format(
    [[<span foreground='%s'>%s</span>]],
    self._private.color or beautiful.colors.white,
    tostring(self._private.text)
  )

  self.markup = string.format("%s%s%s%s%s", bold_start, italic_start, colorized_text, italic_end, bold_end)
end

---Set the bold status of the text
---@param bold boolean?
function text:set_bold(bold)
  self._private.bold = bold
  generate_markup(self)
end

---Set the italic status of the text
---@param italic boolean?
function text:set_italic(italic)
  self._private.italic = italic
  generate_markup(self)
end

---Set the text color
---@param color string
function text:set_color(color)
  self._private.color = color
  generate_markup(self)
end

---Set the text of the widget
---@param _text string
function text:set_text(_text)
  self._private.text = _text
  generate_markup(self)
  self:emit_signal "layout::changed"
  self:emit_signal "widget::redraw_needed"
end

---Create a new text widget
---@param args table
local function new(args)
    -- stylua: ignore start
    args        = args or {}
    args.text   = args.text or ''
    args.font   = args.font or beautiful.font_name
    args.size   = args.size or beautiful.font_size
    args.bold   = args.bold or false
    args.italic = args.italic or false
    args.color  = args.color or beautiful.colors.white
    args.halign = args.halign or nil
    args.valign = args.valign or nil
  -- stylua: ignore end

  local widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = string.format("%s %d", args.font, args.size),
    halign = args.halign,
    valign = args.valign,
  }

  gtable.crush(widget, text, true)

  widget._private.bold = args.bold
  widget._private.italic = args.italic
  widget._private.color = args.color
  widget._private.text = args.text

  generate_markup(widget)

  return widget
end

function text.mt:__call(...)
  return new(...)
end

return setmetatable(text, text.mt)
