---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.layout-picker'
---------------------------------------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
local gobject = require "gears.object"
local gshape = require "gears.shape"
local gtable = require "gears.table"
local wibox = require "wibox"
local widgets = require "ui.widgets"
local theme_vars = beautiful.popups.layout_picker

local layout_picker, instance = {}, nil

function layout_picker:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true
  self:emit_signal("visibility", true)
end

function layout_picker:hide()
  self.popup.visible = false
  self:emit_signal("visibility", false)
end

function layout_picker:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, layout_picker, true)

  local ll = awful.widget.layoutlist {
    base_layout = wibox.widget {
      layout = wibox.layout.grid.vertical,
      forced_num_cols = 4,
      spacing = theme_vars.button_spacing,
    },
    style = {
      shape_selected = helpers.ui.rounded_rect(),
    },
    widget_template = {
      widget = wibox.container.background,
      id = "background_role",
      forced_width = theme_vars.button_size,
      forced_height = theme_vars.button_size,
      {
        margins = dpi(3),
        widget = wibox.container.margin,
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = theme_vars.button_spacing,
          {
            id = "icon_role",
            forced_height = theme_vars.button_size,
            forced_width = theme_vars.button_size,
            widget = wibox.widget.imagebox,
          },
          -- {
          --     id = 'text_role',
          --     halign = 'center',
          --     widget = wibox.widget.textbox,
          -- },
        },
      },
    },
  }

  ret.popup = awful.popup {
    screen = awful.screen.focused(),
    border_width = 0,
    ontop = true,
    visible = false,
    shape = gshape.rectangle,
    bg = beautiful.colors.transparent,
    placement = function(c)
      local placement_fn_name = beautiful.wibar.position .. "_right"
      return awful.placement[placement_fn_name](c, {
        honor_workarea = true,
        margins = {
          right = beautiful.useless_gap,
          [beautiful.wibar.position] = beautiful.useless_gap,
        },
      })
    end,
    widget = wibox.widget {
      widget = wibox.container.background,
      bg = theme_vars.bg,
      {
        widget = wibox.container.margin,
        margins = theme_vars.paddings,
        ll,
      },
    },
  }

  -- Automatically shows the layout picker when switching keys.
  -- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
  -- keybindings before adding this.
  awful.keygrabber {
    start_callback = function()
      ret.popup.visible = true
    end,
    stop_callback = function()
      ret.popup.visible = false
    end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = { "Escape", "Super_L", "Super_R" },
    keybindings = {
      {
        { "Mod4" },
        " ",
        function()
          awful.layout.set((gtable.cycle_value(ll.layouts, ll.current_layout, 1)))
        end,
      },
      {
        { "Mod4", "Shift" },
        " ",
        function()
          awful.layout.set((gtable.cycle_value(ll.layouts, ll.current_layout, -1)), nil)
        end,
      },
    },
  }

  return ret
end

instance = instance or new()
return instance
