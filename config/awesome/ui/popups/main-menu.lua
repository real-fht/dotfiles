---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.main-menu'
---------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local widgets = require("ui.widgets")

local instance = nil

local function new()
  return widgets.menu.menu({
    widgets.menu.button({
      text = "Terminal Emulator",
      icon = beautiful.icons.laptop_code,
      on_press = function()
        awful.spawn(beautiful.apps.kitty.command)
      end,
    }),
    widgets.menu.button({
      text = "Web Browser",
      icon = beautiful.icons.window,
    }),
    widgets.menu.button({
      text = "File Manager",
      icon = beautiful.icons.file_manager,
    }),
    widgets.menu.button({
      text = "Text Editor",
      icon = beautiful.icons.code,
    }),

    widgets.menu.separator(),

    widgets.menu.sub_menu_button({
      text = "AwesomeWM",
      icon = beautiful.icons.window,
      sub_menu = widgets.menu.menu({
        widgets.menu.button({
          text = "Restart",
          icon = beautiful.icons.reboot,
          on_press = awesome.restart,
        }),
        widgets.menu.button({
          text = "Quit",
          icon = beautiful.icons.exit,
          icon_color = beautiful.colors.red,
        }),
        widgets.menu.button({
          text = "Edit Configuration",
          icon = beautiful.icons.code,
          icon_color = beautiful.colors.cyan,
        }),
      }),
    }),

    widgets.menu.sub_menu_button({
      text = "System",
      icon = beautiful.icons.computer,
      sub_menu = widgets.menu.menu({
        widgets.menu.button({
          text = "Poweroff",
          icon = beautiful.icons.poweroff,
          icon_color = beautiful.colors.red,
          on_press = function()
            awful.spawn("systemctl poweroff")
          end,
        }),
        widgets.menu.button({
          text = "Reboot",
          icon = beautiful.icons.reboot,
          icon_color = beautiful.colors.yellow,
          on_press = function()
            awful.spawn("systemctl reboot")
          end,
        }),
        widgets.menu.button({
          text = "Sleep (Save to RAM)",
          icon = beautiful.icons.moon,
          icon_color = beautiful.colors.magenta,
          on_press = function()
            awful.spawn("systemctl suspend")
          end,
        }),
        widgets.menu.button({
          text = "Hibernate (Save to swapfile)",
          icon = beautiful.icons.download,
          icon_color = beautiful.colors.green,
          on_press = function()
            awful.spawn("systemctl hibernate")
          end,
        }),
      }),
    }),
  })
end

instance = instance or new()
return instance
