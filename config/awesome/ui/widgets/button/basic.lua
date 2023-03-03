---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.button.basic'
---------------------------------------------------------------------------------

local animation = require "modules.animation"
local beautiful = require "beautiful"
local helpers = require "helpers"
local wcontainer = require "ui.widgets.container"

local basic = { mt = {} }

---@class MarginsOrPaddings
---@field left number?
---@field up number?
---@field down number?
---@field right number?

---@class HorizontalAlignement "left"|"center"|"right"
---@class VerticalAlignement "top"|"center"|"bottom"

---@class BasicButtonArgs:ContainerArgs
---@field normal_bg              string?
---@field hover_bg               string?
---@field press_bg               string?
---@field normal_border_width    number?
---@field hover_border_width     number?
---@field press_border_width     number?
---@field normal_border_color    string?
---@field hover_border_color     string?
---@field press_border_color     string?
---@field on_hover               function?
---@field on_leave               function?
---@field on_press               function?
---@field on_release             function?
---@field on_secondary_press     function?
---@field on_secondary_release   function?
---@field on_scroll_up           function?
---@field on_scroll_down         function?
---@field halign                 HorizontalAlignement?
---@field valign                 VerticalAlignement?
---@field hover_effect           boolean?
---@field press_effect           boolean?
---@field child                  BasicButtonArgs

---@class BasicButtonStateArgs:BasicButtonArgs
---@field on_normal_bg           string?
---@field on_hover_bg            string?
---@field on_press_bg            string?
---@field on_normal_border_width number?
---@field on_hover_border_width  number?
---@field on_press_border_width  number?
---@field on_normal_border_color string?
---@field on_hover_border_color  string?
---@field on_press_border_color  string?
---@field on_turn_on             function?
---@field on_turn_off            function?
---@field on_by_default          boolean?
---@field child                  BasicButtonStateArgs

---Ensures that all the required arguments are met for a button
---@param args BasicButtonArgs|BasicButtonStateArgs?
---@return BasicButtonArgs|BasicButtonStateArgs?
local function ensure_button_args(args)
  -- stylua: ignore start
  args                        = args or {}

  -- Coloring
  args.normal_bg              = args.normal_bg or beautiful.basic_button.normal_bg
  args.hover_bg               = args.hover_bg or helpers.color.lighten(args.normal_bg, 10)
  args.press_bg               = args.press_bg or helpers.color.darken(args.normal_bg, 10)
  -- -*-
  args.on_normal_bg           = args.on_normal_bg or helpers.color.lighten(args.normal_bg, 15)
  args.on_hover_bg            = args.on_hover_bg or helpers.color.lighten(args.on_normal_bg, 10)
  args.on_press_bg            = args.on_press_bg or helpers.color.darken(args.on_normal_bg, 10)

  -- Border width
  args.normal_border_width    = args.normal_border_width or beautiful.basic_button.normal_border_width
  args.hover_border_width     = args.hover_border_width or beautiful.basic_button.hover_border_width
  args.press_border_width     = args.press_border_width or beautiful.basic_button.press_border_width
  args.on_normal_border_width = args.on_normal_border_width or beautiful.basic_button.on_normal_border_width
  args.on_hover_border_width  = args.on_hover_border_width or beautiful.basic_button.on_hover_border_width
  args.on_press_border_width  = args.on_press_border_width or beautiful.basic_button.on_press_border_width

  -- Border color
  args.normal_border_color    = args.normal_border_color or beautiful.basic_button.normal_border_color
  args.hover_border_color     = args.hover_border_color or beautiful.basic_button.hover_border_color
  args.press_border_color     = args.press_border_color or beautiful.basic_button.press_border_color
  args.on_normal_border_color = args.on_normal_border_color or beautiful.basic_button.on_normal_border_color
  args.on_hover_border_color  = args.on_hover_border_color or beautiful.basic_button.on_hover_border_color
  args.on_press_border_color  = args.on_press_border_color or beautiful.basic_button.on_press_border_color

  -- Callbacks
  args.on_hover               = args.on_hover or nil
  args.on_leave               = args.on_leave or nil
  args.on_press               = args.on_press or nil
  args.on_release             = args.on_release or nil
  args.on_secondary_press     = args.on_secondary_press or nil
  args.on_secondary_release   = args.on_secondary_release or nil
  args.on_scroll_up           = args.on_scroll_up or nil
  args.on_scroll_down         = args.on_scroll_down or nil
  args.on_turn_on             = args.on_turn_on or nil
  args.on_turn_off            = args.on_turn_off or nil

  -- Arguments for the button container
  args.forced_width           = args.forced_width or nil
  args.forced_height          = args.forced_height or nil
  args.shape                  = args.shape or beautiful.basic_button.shape
  args.margins                = args.margins or beautiful.basic_button.margins
  args.paddings               = args.paddings or beautiful.basic_button.paddings
  args.halign                 = args.halign or "center"
  args.valign                 = args.valign or "center"

  -- Should we add a custom hover/press effect to the button?
  -- This adds a hover/press cursor effect and a cool color change
  args.hover_effect           = args.hover_effect == nil and true or args.hover_effect
  args.press_effect           = args.press_effect == nil and true or args.press_effect

  -- Should the button be on by default?
  args.on_by_default          = args.on_by_default == nil and false or args.on_by_default

  -- stylua: ignore end

  return args
end

---Applies some animation for given button
---@param widget table
---@param bg string
---@param border_color string
---@param border_width number
local function button_effect(widget, bg, border_color, border_width)
  local targets = {}

  if bg then
    targets.bg = helpers.color.hex_to_rgba(bg)
  end
  if border_color then
    targets.border_color = helpers.color.hex_to_rgba(border_color)
  end
  if border_width then
    targets.border_width = border_width
  end

  widget.animation:set(targets)
end

---Function to create a generic button
---@param args table
local function create_button(args)
  -- Some stuff for the container...
  args.bg = args.normal_bg
  args.border_width = args.normal_border_width
  args.border_color = args.normal_border_color

  -- Our button is nothing more than a container with some hooked up events
  local widget = wcontainer(args)

  if args.hover_effect then
    helpers.ui.add_hover_cursor(widget)
  end

  -- Color, border{width/color} animation
  widget.animation = animation:new {
    pos = {
      bg = helpers.color.hex_to_rgba(args.normal_bg),
      border_color = helpers.color.hex_to_rgba(args.normal_border_color),
      border_width = args.normal_border_width,
    },
    duration = 1 / 8,
    easing = animation.easing.linear,
    update = function(_, pos)
      if pos.bg then
        widget:set_bg(helpers.color.rgba_to_hex(pos.bg))
      end

      if pos.border_color then
        widget:set_border_color(helpers.color.rgba_to_hex(pos.border_color))
      end

      if pos.border_width then
        widget:set_border_width(pos.border_width)
      end
    end,
  }

  return widget
end

---Creates a basic button, with no state management.
---@param args BasicButtonArgs
function basic.normal(args)
  ---@type BasicButtonArgs
  args = ensure_button_args(args)
  local widget = create_button(args)

  widget:connect_signal("mouse::enter", function(self, results)
    -- Only make the hover effect if there's a purpose, for example, a on_press, on_leave,
    -- or even a on_hover callback to execute.
    -- It wouldn't make sense to indicate that the button is being hovered if there's nothing to execute
    if args.hover_effect == true and (args.on_hover ~= nil or args.on_leave ~= nil or args.on_press ~= nil) then
      button_effect(widget, args.hover_bg, args.hover_border_color, args.hover_border_width)
    end

    if args.on_hover ~= nil then
      args.on_hover(self, results)
    end

    if args.child and args.child.on_hover ~= nil then
      args.child:on_hover(self, results)
    end
  end)

  widget:connect_signal("mouse::leave", function(self, results)
    -- Why checking if the widget is being pressed or not?
    -- Since even if I have the mouse button *still pressed*, leaving the widget
    -- area should make me stop pressing the said widget
    if widget.button == 1 then
      if args.press_effect == true and (args.on_release ~= nil or args.on_press ~= nil) then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.child and args.child.on_release ~= nil then
        -- Simulate a button release for the child
        args.child:on_release(self, 1, 1, widget.button, {}, results)
      end
    end
    -- Same deal here but for right click
    if widget.button == 3 then
      if args.press_effect == true and (args.on_secondary_release ~= nil or args.on_secondary_press ~= nil) then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.child and args.child.on_secondary_release ~= nil then
        -- Simulate a button release for the child
        args.child:on_secondary_release(self, 3, 3, widget.button, {}, results)
      end
    end

    if args.hover_effect and (args.on_hover ~= nil or args.on_press ~= nil or args.on_leave ~= nil) then
      button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
    end

    if args.on_leave ~= nil then
      args.on_leave(self, results)
    end

    if args.child and args.child.on_leave ~= nil then
      args.child:on_leave(self, results)
    end
  end)

  widget:connect_signal("button::press", function(self, lx, ly, button, mods, results)
    if #mods > 0 then
      return
    end

    widget.button = button -- check mouse::leave signal

    if button == 1 then
      if args.press_effect == true and (args.on_release ~= nil or args.on_press ~= nil) then
        button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
      end

      if args.on_press ~= nil then
        args.on_press(self, lx, ly, button, mods, results)
      end

      if args.child and args.child.on_press ~= nil then
        args.child:on_press(self, lx, ly, button, mods, results)
      end
    elseif button == 3 then
      if args.press_effect == true and (args.on_secondary_release ~= nil or args.on_secondary_press ~= nil) then
        button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
      end

      if args.on_secondary_release ~= nil then
        args.on_secondary_release(self, lx, ly, button, mods, results)
      end

      if args.child and args.child.on_secondary_press ~= nil then
        args.child:on_secondary_press(self, lx, ly, button, mods, results)
      end
    elseif button == 4 then
      if args.on_scroll_up ~= nil then
        args.on_scroll_up(self, lx, ly, button, mods, results)
      end
    elseif button == 5 then
      if args.on_scroll_down ~= nil then
        args.on_scroll_down(self, lx, ly, button, mods, results)
      end
    end
  end)

  widget:connect_signal("button::release", function(self, lx, ly, button, mods, results)
    -- if #mods > 0 then
    --     return
    -- end

    widget.button = nil -- check mouse::leave signal

    if button == 1 then
      if args.press_effect == true and (args.on_release ~= nil or args.on_press ~= nil) then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.on_release ~= nil then
        args.on_release(self, lx, ly, button, mods, results)
      end

      if args.child and args.child.on_release ~= nil then
        -- Simulate a button release for the child
        args.child:on_release(self, lx, ly, button, mods, results)
      end
    elseif button == 3 then
      if args.press_effect == true and (args.on_secondary_release ~= nil or args.on_secondary_press ~= nil) then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.on_secondary_release ~= nil then
        args.on_secondary_release(self, lx, ly, button, mods, results)
      end

      if args.child and args.child.on_secondary_release ~= nil then
        -- Simulate a button_secondary release for the child
        args.child:on_secondary_release(self, lx, ly, button, mods, results)
      end
    end
  end)

  return widget
end

---Creates a basic button, with no state management.
---@param args BasicButtonArgs
function basic.state(args)
  ---@type BasicButtonStateArgs
  args = ensure_button_args(args)
  local widget = create_button(args)
  widget._private.state = false ---@type boolean

  function widget:turn_on()
    if widget._private.state == false then
      button_effect(widget, args.on_normal_bg, args.on_normal_border_color, args.on_normal_border_width)
      -- Required for text button to work.
      if args.child and args.child.on_turn_on then
        args.child:on_turn_on()
      end
      -- Update then the state
      widget._private.state = true
    end
  end

  function widget:turn_off()
    if widget._private.state == true then
      button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      -- Required for text button
      if args.child and args.child.on_turn_off then
        args.child:on_turn_off()
      end
      -- Update then the state
      widget._private.state = false
    end
  end

  function widget:toggle()
    if widget._private.state then
      widget:turn_off()
    else
      widget:turn_on()
    end
  end

  if args.on_by_default == true then
    widget:turn_on()
  end

  widget:connect_signal("mouse::enter", function(self, results)
    -- Only make the hover effect if there's a purpose, for example, a on_press, on_leave,
    -- or even a on_hover callback to execute.
    -- It wouldn't make sense to indicate that the button is being hovered if there's nothing to execute
    if args.hover_effect == true and (args.on_hover ~= nil or args.on_leave ~= nil or args.on_press ~= nil) then
      if widget._private.state == true then
        button_effect(widget, args.on_hover_bg, args.on_hover_border_color, args.on_hover_border_width)
      else
        button_effect(widget, args.hover_bg, args.hover_border_color, args.hover_border_width)
      end
    end

    if args.on_hover ~= nil then
      args.on_hover(self, results)
    end
    if args.child and args.child.on_hover ~= nil then
      args.child:on_hover(self, results)
    end
  end)

  widget:connect_signal("mouse::leave", function(self, results)
    if widget.button ~= nil then
      -- The additional true at the end is to determine if the signal is either a true
      -- signal or a fake simulated signal.
      widget:emit_signal("button::release", 1, 1, widget.button, {}, results, true)
    end

    if args.hover_effect == true and (args.on_hover ~= nil or args.on_leave ~= nil or args.on_press ~= nil) then
      if widget._private.state == true then
        button_effect(widget, args.on_normal_bg, args.on_normal_border_color, args.on_normal_border_width)
      else
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end
    end

    if args.on_leave ~= nil then
      args.on_leave(self, results, self._private.state)
    end
    if args.child and args.child.on_leave ~= nil then
      args.child:on_leave(self, results, self._private.state)
    end
  end)

  widget:connect_signal("button::press", function(self, lx, ly, button, mods, results)
    if #mods > 0 then
      return
    end

    widget.button = button -- check mouse::leave signal

    if button == 1 then
      if args.press_effect == true and (args.on_press ~= nil or args.on_release ~= nil) then
        if widget._private.state == true then
          button_effect(widget, args.on_press_bg, args.on_press_border_color, args.on_press_border_width)
        else
          button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
        end
      end

      if args.on_press ~= nil then
        args.on_press(self, lx, ly, button, mods, results)
      end

      if args.child and type(args.child.on_press) == "function" then
        args.child:on_press(self, lx, ly, button, mods, results)
      end

      if widget._private.state == false then
        widget:turn_on()
        if args.on_turn_on ~= nil then
          args.on_turn_on(self, lx, ly, button, mods, results)
        end
      elseif widget._private.state == true then
        widget:turn_off()
        if args.on_turn_off ~= nil then
          args.on_turn_off(self, lx, ly, button, mods, results)
        end
      end
    elseif button == 3 then
      if args.press_effect == true and (args.on_secondary_press ~= nil or args.on_secondary_release ~= nil) then
        if widget._private.state then
          button_effect(widget, args.on_press_bg, args.on_press_border_color, args.on_press_border_width)
        else
          button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
        end
      end

      if args.on_secondary_press ~= nil then
        args.on_secondary_press(self, lx, ly, button, mods, results)
      end

      if args.child and args.child.on_secondary_press ~= nil then
        args.child:on_secondary_press(self, lx, ly, button, mods, results)
      end
    elseif button == 4 then
      if args.on_scroll_up ~= nil then
        args.on_scroll_up(self, lx, ly, button, mods, results)
      end
    elseif button == 5 then
      if args.on_scroll_down ~= nil then
        args.on_scroll_down(self, lx, ly, button, mods, results)
      end
    end
  end)

  widget:connect_signal("button::release", function(self, lx, ly, button, mods, results)
    -- if #mods > 0 then
    --     return
    -- end

    widget.button = nil -- check mouse::leave signal

    if button == 1 then
      if args.press_effect == true and (args.on_secondary_press ~= nil or args.on_secondary_release ~= nil) then
        if widget._private.state then
          button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
        else
          button_effect(widget, args.on_normal_bg, args.on_normal_border_color, args.on_normal_border_width)
        end
      end

      if args.on_release ~= nil then
        args.on_release(self, lx, ly, button, mods, results)
      end

      if args.child and args.child.on_release ~= nil then
        -- Simulate a button release for the child
        args.child:on_release(self, lx, ly, button, mods, results)
      end
    elseif button == 3 then
      if args.press_effect == true and (args.on_secondary_press ~= nil or args.on_secondary_release ~= nil) then
        if widget._private.state then
          button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
        else
          button_effect(widget, args.on_normal_bg, args.on_normal_border_color, args.on_normal_border_width)
        end
      end

      if type(args.on_secondary_release) == "function_secondary" then
        args.on_secondary_release(self, lx, ly, button, mods, results)
      end

      if args.child and type(args.child.on_secondary_release) == "function" then
        -- Simulate a button_secondary release for the child
        args.child:on_secondary_release(self, lx, ly, button, mods, results)
      end
    end
  end)

  return widget
end

---@param args table
function basic.mt:__call(args)
  assert(args.type == "normal" or args.type == "state", "Invalid button type: " .. args.type)
  return basic[args.type](args)
end

return setmetatable(basic, basic.mt)
