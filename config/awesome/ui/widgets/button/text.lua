---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.button.text'
---------------------------------------------------------------------------------

local animation = require("modules.animation")
local beautiful = require("beautiful")
local basic = require("ui.widgets.button.basic")
local gtable = require("gears.table")
local helpers = require("helpers")
local twidget = require("ui.widgets.text")

local text = { mt = {} }

-- Assign generic functions to this object so we can crush it with the new textwidget
-- Also we don't use included functions since they target _private., but we target
-- _private.text to we can call them directly from the button widget
local text_widget_generic = {}

---Set the bold status of the text
---@param bold boolean?
function text_widget_generic:set_bold(bold)
  self._private.text:set_bold(bold)
end

---Set the italic status of the text
---@param italic boolean?
function text_widget_generic:set_italic(italic)
  self._private.text:set_italic(italic)
end

---Set the text color
---@param color string
function text_widget_generic:set_color(color)
  self._private.text:set_color(color)
end

---Set the text of the widget
---@param _text string
function text_widget_generic:set_text(_text)
  self._private.text:set_text(_text)
end

---@class TextButtonArgs:BasicButtonArgs
---@field normal_fg     string?
---@field hover_fg      string?
---@field press_fg      string?
---@field on_normal_fg  string?
---@field on_hover_fg   string?
---@field on_press_fg   string?
---@field text          string?
---@field on_text       string?

---Ensures that all the required arguments are met for a text button
---@param args TextButtonArgs
---@return TextButtonArgs
local function ensure_button_args(args)
  -- stylua: ignore start
  args = args or {}

  -- Coloring
  args.normal_fg = args.normal_fg or beautiful.colors.white
  args.hover_fg = args.hover_fg or beautiful.colors.white
  args.press_fg = args.press_fg or beautiful.colors.grey
  args.on_normal_fg = args.on_normal_fg or beautiful.accent
  args.on_hover_fg = args.on_hover_fg or beautiful.accent
  args.on_press_fg = args.on_press_fg or helpers.color.darken(beautiful.accent, 10)

  -- Text
  args.text = args.text or 'Text Button'
  args.on_text = args.on_text or args.text

  -- stylua: ignore end

  return args
end

---Function to create a generic button
---@param args table
---@param type_ 'normal'|'state'
local function create_button(args, type_)
  -- Some stuff for the text widget...
  args.color = args.normal_fg

  -- Create our text widget.
  local text_widget = twidget(args)

  args.child = text_widget
  type_ = not type_ and "normal" or type_
  local widget = basic[type_](args)

  gtable.crush(widget, text_widget_generic)
  widget._private.text = text_widget

  widget.text_animation = animation:new({
    pos = helpers.color.hex_to_rgba(args.normal_fg),
    easing = animation.easing.linear,
    duration = 1 / 4,
    update = function(_, pos)
      text_widget:set_color(helpers.color.rgba_to_hex(pos))
    end,
  })

  return widget, text_widget
end

---Applies some animation for text button
---@param widget table
---@param color string
local function button_effect(widget, color)
  widget.text_animation:set(helpers.color.hex_to_rgba(color))
end

---@param args TextButtonArgs
function text.normal(args)
  args = ensure_button_args(args)
  local widget, text_widget = create_button(args, "normal")

  function text_widget:on_hover()
    if args.hover_effect then
      button_effect(widget, args.hover_fg)
    end
  end

  function text_widget:on_leave()
    if args.hover_effect then
      button_effect(widget, args.normal_fg)
    end
  end

  function text_widget:on_press()
    if args.press_effect then
      button_effect(widget, args.press_fg)
    end
  end

  function text_widget:on_release()
    if args.press_effect then
      button_effect(widget, args.normal_fg)
    end
  end

  return widget
end

---@param args TextButtonArgs
function text.state(args)
  args = ensure_button_args(args)
  local widget, text_widget = create_button(args, "state")

  function text_widget:on_hover(self)
    if args.hover_effect then
      return
    end
    if self.turned_on then
      button_effect(widget, args.on_hover_fg)
    else
      button_effect(widget, args.hover_fg)
    end
  end

  function text_widget:on_leave(self)
    if args.hover_effect then
      return
    end
    if self.turned_on then
      button_effect(widget, args.on_normal_fg)
    else
      button_effect(widget, args.normal_fg)
    end
  end

  function text_widget:on_turn_on()
    if args.press_effect then
      button_effect(widget, args.on_press_fg)
    end
    text_widget:set_text(args.on_text)
  end

  function text_widget:on_turn_off()
    if args.press_effect then
      button_effect(widget, args.press_fg)
    end
    text_widget:set_text(args.text)
  end

  if args.on_by_default then
    text_widget:on_turn_on()
  end

  function text_widget:on_release()
    if args.press_effect == false then
      return
    end
    if self.turned_on then
      button_effect(widget, args.on_normal_fg)
    else
      button_effect(widget, args.normal_fg)
    end
  end

  return widget
end

return text
