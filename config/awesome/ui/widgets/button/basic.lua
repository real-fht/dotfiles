---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.widgets.button.basic'
---------------------------------------------------------------------------------

local animation = require("modules.animation")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wcontainer = require("ui.widgets.container")

local basic = { mt = {} }

---@class MarginsOrPaddings
---@field left number?
---@field up number?
---@field down number?
---@field right number?

---@enum HorizontalAlignement "left"|"center"|"right"
---@enum VerticalAlignement "top"|"center"|"bottom"

---@class BasicButtonArgs
---@field normal_bg              string?
---@field hover_bg               string?
---@field press_bg               string?
---@field on_normal_bg           string?
---@field on_hover_bg            string?
---@field on_press_bg            string?
---@field normal_border_width    number?
---@field hover_border_width     number?
---@field press_border_width     number?
---@field on_normal_border_width number?
---@field on_hover_border_width  number?
---@field on_press_border_width  number?
---@field normal_border_color    string?
---@field hover_border_color     string?
---@field press_border_color     string?
---@field on_normal_border_color string?
---@field on_hover_border_color  string?
---@field on_press_border_color  string?
---@field on_hover               function?
---@field on_leave               function?
---@field on_press               function?
---@field on_release             function?
---@field on_secondary_press     function?
---@field on_secondary_release   function?
---@field on_scroll_up           function?
---@field on_scroll_down         function?
---@field on_turn_on             function?
---@field on_turn_off            function?
---@field forced_width           number?
---@field forced_height          number?
---@field shape                  any?
---@field margins                number|MarginsOrPaddings
---@field paddings               number|MarginsOrPaddings?
---@field halign                 HorizontalAlignement?
---@field valign                 VerticalAlignement?
---@field hover_effect           boolean?
---@field on_by_default          boolean?
---@field child                  BasicButtonArgs

---Ensures that all the required arguments are met for a button
---@param args BasicButtonArgs
---@return BasicButtonArgs
local function ensure_button_args(args)
  -- stylua: ignore start
  args                        = args or {}

  -- Coloring
  args.normal_bg              = args.normal_bg or beautiful.colors.black2
  args.hover_bg               = args.hover_bg or helpers.color.lighten(args.normal_bg, 15)
  args.press_bg               = args.press_bg or helpers.color.darken(args.normal_bg, 15)
  -- -*-
  args.on_normal_bg           = args.on_normal_bg or helpers.color.lighten(args.normal_bg, 5)
  args.on_hover_bg            = args.on_hover_bg or helpers.color.lighten(args.normal_bg, 20)
  args.on_press_bg            = args.on_press_bg or helpers.color.darken(args.normal_bg, 10)

  -- Border width
  args.normal_border_width    = args.normal_border_width or 0
  args.hover_border_width     = args.hover_border_width or 0
  args.press_border_width     = args.press_border_width or 0
  args.on_normal_border_width = args.on_normal_border_width or 0
  args.on_hover_border_width  = args.on_hover_border_width or 0
  args.on_press_border_width  = args.on_press_border_width or 0

  -- Border color
  args.normal_border_color    = args.normal_border_color or beautiful.colors.transparent
  args.hover_border_color     = args.hover_border_color or beautiful.colors.transparent
  args.press_border_color     = args.press_border_color or beautiful.colors.transparent
  args.on_normal_border_color = args.on_normal_border_color or beautiful.colors.transparent
  args.on_hover_border_color  = args.on_hover_border_color or beautiful.colors.transparent
  args.on_press_border_color  = args.on_press_border_color or beautiful.colors.transparent

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
  args.shape                  = args.shape or helpers.ui.rounded_rect(beautiful.border_radius)
  args.margins                = args.margins or dpi(0)
  args.paddings               = args.paddings or dpi(0)
  args.halign                 = args.halign or "center"
  args.valign                 = args.valign or "center"

  -- Shouldwe add a custom hover effect to the button?
  -- This adds a hover cursor effect and a cool color change
  args.hover_effect           = args.hover_effect == nil and true or args.hover_effect

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
  widget.animation = animation:new({
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
  })

  return widget
end

---Creates a basic button, with no state management.
---@param args BasicButtonArgs
function basic.normal(args)
  args = ensure_button_args(args)
  local widget = create_button(args)

  widget:connect_signal("mouse::enter", function(self, results)
    if args.hover_effect == true then
      button_effect(widget, args.hover_bg, args.hover_border_color, args.hover_border_width)
    end

    if type(args.on_hover) == "function" then
      args.on_hover(self, results)
    end

    if args.child and type(args.child.on_hover) == "function" then
      args.child:on_hover(self, results)
    end
  end)

  widget:connect_signal("mouse::leave", function(self, results)
    -- Why checking if the widget is being pressed or not?
    -- Since even if I have the mouse button *still pressed*, leaving the widget
    -- area should make me stop pressing the said widget
    if widget.button == 1 then
      if type(args.on_release) == "function" or type(args.on_press) == "function" then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.child and type(args.child.on_release) == "function" then
        -- Simulate a button release for the child
        args.child:on_release(self, 1, 1, widget.button, {}, results)
      end
    end
    -- Same deal here but for right click
    if widget.button == 3 then
      if type(args.on_secondary_release) == "function" or type(args.on_secondary_press) == "function" then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.child and type(args.child.on_secondary_release) == "function" then
        -- Simulate a button release for the child
        args.child:on_secondary_release(self, 3, 3, widget.button, {}, results)
      end
    end

    if args.hover_effect == true then
      button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
    end

    if type(args.on_leave) == "function" then
      args.on_leave(self, results)
    end

    if args.child and type(args.child.on_leave) == "function" then
      args.child:on_leave(self, results)
    end
  end)

  widget:connect_signal("button::press", function(self, lx, ly, button, mods, results)
    -- if #mods > 0 then
    --     return
    -- end

    widget.button = button -- check mouse::leave signal

    if button == 1 then
      if type(args.on_press) == "function" then
        button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
        args.on_press(self, lx, ly, button, mods, results)
      end

      if args.child and type(args.child.on_press) == "function" then
        args.child:on_press(self, lx, ly, button, mods, results)
      end
    elseif button == 3 then
      if type(args.on_secondary_release) == "function" then
        button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
        args.on_secondary_press(self, lx, ly, button, mods, results)
      end

      if args.child and type(args.child.on_secondary_press) == "function" then
        args.child:on_secondary_press(self, lx, ly, button, mods, results)
      end
    elseif button == 4 then
      if type(args.on_scroll_up) == "function" then
        args.on_scroll_up(self, lx, ly, button, mods, results)
      end
    elseif button == 5 then
      if type(args.on_scroll_down) == "function" then
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
      if args.on_release ~= nil or args.on_press ~= nil then
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
      if type(args.on_secondary_release) == "function" or type(args.on_secondary_press) == "function" then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
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

---Creates a basic button, with no state management.
---@param args BasicButtonArgs
function basic.state(args)
  args = ensure_button_args(args)
  local widget = create_button(args)
  widget.turned_on = false ---@type boolean

  function widget:turn_on()
    if widget.turned_on then
      return
    end

    button_effect(widget, args.on_normal_bg, args.on_normal_border_color, args.on_normal_border_width)

    if args.child and args.child.on_turn_on then
      args.child:on_turn_on()
    end

    widget.turned_on = true
  end

  function widget:turn_off()
    if not widget.turned_on then
      return
    end

    button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)

    if args.child and args.child.on_turn_off then
      args.child:on_turn_off()
    end

    widget.turned_on = false
  end

  function widget:toggle()
    if widget.turned_on then
      widget:turn_off()
    else
      widget:turn_on()
    end
  end

  if args.on_by_default then
    widget:turn_on()
  end

  widget:connect_signal("mouse::enter", function(self, results)
    if not args.hover_effect then
      return
    end

    if widget.turned_on then
      button_effect(widget, args.on_hover_bg, args.on_hover_border_color, args.on_hover_border_width)
    else
      button_effect(widget, args.hover_bg, args.hover_border_color, args.hover_border_width)
    end

    if type(args.on_hover) == "function" then
      args.on_hover(self, results)
    end

    if args.child and type(args.child.on_hover) == "function" then
      args.child:on_hover(self, results)
    end
  end)

  widget:connect_signal("mouse::leave", function(self, results)
    -- Why checking if the widget is being pressed or not?
    -- Since even if I have the mouse button *still pressed*, leaving the widget
    -- area should make me stop pressing the said widget
    if widget.button == 1 then
      if type(args.on_release) == "function" or type(args.on_press) == "function" then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.child and type(args.child.on_release) == "function" then
        -- Simulate a button release for the child
        args.child:on_release(self, 1, 1, widget.button, {}, results)
      end
    end
    -- Same deal here but for right click
    if widget.button == 3 then
      if type(args.on_secondary_release) == "function" or type(args.on_secondary_press) == "function" then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end

      if args.child and type(args.child.on_secondary_release) == "function" then
        -- Simulate a button release for the child
        args.child:on_secondary_release(self, 3, 3, widget.button, {}, results)
      end
    end

    if args.hover_effect == true then
      if widget.turned_on then
        button_effect(widget, args.on_normal_bg, args.on_normal_border_color, args.on_normal_border_width)
      else
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
      end
    end

    if type(args.on_leave) == "function" then
      args.on_leave(self, results)
    end

    if args.child and type(args.child.on_leave) == "function" then
      args.child:on_leave(self, results)
    end
  end)

  widget:connect_signal("button::press", function(self, lx, ly, button, mods, results)
    -- if #mods > 0 then
    --     return
    -- end

    widget.button = button -- check mouse::leave signal

    if button == 1 then
      if widget.turned_on then
        widget:turn_off()
        if args.on_turn_off then
          args.on_turn_off(self, lx, ly, button, mods, results)
        end
      elseif not widget.turned_on then
        widget:turn_on()
        if args.on_turn_on then
          args.on_turn_on(self, lx, ly, button, mods, results)
        end
      end

      if args.child and type(args.child.on_press) == "function" then
        args.child:on_press(self, lx, ly, button, mods, results)
      end

      if type(args.on_press) == "function" then
        -- button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
        args.on_press(self, lx, ly, button, mods, results)
      end
    elseif button == 3 then
      if type(args.on_secondary_release) == "function" then
        button_effect(widget, args.press_bg, args.press_border_color, args.press_border_width)
        args.on_secondary_press(self, lx, ly, button, mods, results)
      end

      if args.child and type(args.child.on_secondary_press) == "function" then
        args.child:on_secondary_press(self, lx, ly, button, mods, results)
      end
    elseif button == 4 then
      if type(args.on_scroll_up) == "function" then
        args.on_scroll_up(self, lx, ly, button, mods, results)
      end
    elseif button == 5 then
      if type(args.on_scroll_down) == "function" then
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
      if args.on_release ~= nil or args.on_press ~= nil or args.on_turn_off ~= nil or args.on_turn_on ~= nil then
        if widget.turned_on then
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
      if type(args.on_secondary_release) == "function" or type(args.on_secondary_press) == "function" then
        button_effect(widget, args.normal_bg, args.normal_border_color, args.normal_border_width)
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
