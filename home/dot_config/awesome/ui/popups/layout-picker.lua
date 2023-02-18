---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.layout-picker'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local gobject = require("gears.object")
local gshape = require("gears.shape")
local gtable = require("gears.table")
local wibox = require("wibox")
local widgets = require("ui.widgets")

local layout_picker, instance = {}, nil

function layout_picker:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true
  self:emit_signal("visibility", true)
end

function layout_picker:hide()
  self.popup.visible = false
  self.emit_signal("visibility", false)
end

function layout_picker:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function new()
  local ret = gobject({})
  gtable.crush(ret, layout_picker, true)

  local ll = awful.widget.layoutlist({
    base_layout = wibox.widget({
      layout = wibox.layout.grid.vertical,
      forced_num_cols = 4,
      spacing = beautiful.layout_picker_button_spacing,
    }),
    style = {
      shape_selected = helpers.ui.rounded_rect(),
    },
    widget_template = {
      widget = wibox.container.background,
      id = "background_role",
      forced_width = beautiful.layout_picker_button_size,
      forced_height = beautiful.layout_picker_button_size,
      {
        margins = dpi(3),
        widget = wibox.container.margin,
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = beautiful.layout_picker_button_spacing,
          {
            id = "icon_role",
            forced_height = beautiful.layout_picker_button_size,
            forced_width = beautiful.layout_picker_button_size,
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
  })

  ret.popup = awful.popup({
    screen = awful.screen.focused(),
    border_width = 0,
    ontop = true,
    visible = false,
    shape = gshape.rectangle,
    bg = beautiful.colors.transparent,
    placement = function(c)
      return awful.placement.bottom_left(c, {
        honor_workarea = true,
        margins = { left = beautiful.useless_gap, bottom = beautiful.useless_gap },
      })
    end,
    widget = wibox.widget({
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.container.background,
        bg = beautiful.layout_picker_alt_bg,
        {
          widget = wibox.container.margin,
          margins = beautiful.layout_picker_paddings,
          {
            layout = wibox.layout.align.horizontal,
            widgets.text({ text = "Layout Picker" }),
            nil,
            widgets.button.text.normal({
              font = beautiful.icons.xmark.font,
              text = beautiful.icons.xmark.icon,
              normal_bg = beautiful.colors.transparent,
              normal_fg = beautiful.colors.grey_fg,
              halign = "center",
              valign = "center",
              forced_height = dpi(24),
              forced_width = dpi(24),
              size = 12,
              on_release = function()
                ret:hide()
              end,
            }),
          },
        },
      },
      {
        widget = wibox.container.background,
        bg = beautiful.layout_picker_bg,
        {
          widget = wibox.container.margin,
          margins = beautiful.layout_picker_paddings,
          ll,
        },
      },
    }),
    -- placement = function(c)
    --     return awful.placement.top_left(c, {
    --         honor_workarea = true,
    --         margins = { left = beautiful.useless_gap, top = beautiful.useless_gap },
    --     })
    -- end,
  })

  -- Automatically shows the layout picker when switching keys.
  -- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
  -- keybindings before adding this.
  awful.keygrabber({
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
  })

  return ret
end

instance = instance or new()
return instance
