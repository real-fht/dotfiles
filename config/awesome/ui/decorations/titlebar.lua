---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.decorations.titlebar'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local icon_theme = require("modules.icon_theme")
local gshape = require("gears.shape")
local wibox = require("wibox")
local widgets = require("ui.widgets")

client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button({}, 1, function()
      c:activate({ context = "titlebar", action = "mouse_move" })
    end),
    awful.button({}, 3, function()
      c:activate({ context = "titlebar", action = "mouse_resize" })
    end),
  }

  local client_icon = wibox.widget({
    widget = wibox.widget.imagebox,
    image = icon_theme:get_client_icon_path(c),
    resize = true,
  })

  local close_button = widgets.button.basic.normal({
    on_normal_bg = beautiful.titlebar_close_button_color_focus,
    normal_bg = beautiful.titlebar_close_button_color_normal,
    forced_height = beautiful.titlebar_button_size,
    forced_width = beautiful.titlebar_button_size,
    shape = gshape.circle,
    halign = "center",
    valign = "center",
    on_press = function()
      c:kill()
    end,
  })

  local maximize_button = widgets.button.basic.state({
    on_normal_bg = beautiful.titlebar_maximize_button_color_focus,
    normal_bg = beautiful.titlebar_maximize_button_color_normal,
    forced_height = beautiful.titlebar_button_size,
    forced_width = beautiful.titlebar_button_size,
    shape = gshape.circle,
    halign = "center",
    valign = "center",
    on_press = function()
      c.maximized = not c.maximized
    end,
  })

  local minimize_button = widgets.button.basic.normal({
    normal_bg = beautiful.titlebar_minimize_button_color_focus,
    forced_height = beautiful.titlebar_button_size,
    forced_width = beautiful.titlebar_button_size,
    shape = gshape.circle,
    halign = "center",
    valign = "center",
    on_press = function()
      c.minimized = true
    end,
  })

  c:connect_signal("focus", function()
    close_button:set_bg(beautiful.titlebar_close_button_color_focus)
    maximize_button:set_bg(beautiful.titlebar_maximize_button_color_focus)
    minimize_button:set_bg(beautiful.titlebar_minimize_button_color_focus)
  end)

  c:connect_signal("unfocus", function()
    close_button:set_bg(beautiful.titlebar_close_button_color_normal)
    maximize_button:set_bg(beautiful.titlebar_maximize_button_color_normal)
    minimize_button:set_bg(beautiful.titlebar_minimize_button_color_normal)
  end)

  awful.titlebar(c, {
    position = "left",
  }).widget = {
    widget = wibox.container.margin,
    margins = beautiful.titlebar_paddings,
    buttons = buttons,
    {
      layout = wibox.layout.align.vertical,
      expand = "none",
      buttons = buttons,
      {
        layout = wibox.layout.fixed.vertical,
        spacing = beautiful.titlebar_button_spacing,
        close_button,
        maximize_button,
        minimize_button,
      },
      nil,
      client_icon,
    },
  }
end)
