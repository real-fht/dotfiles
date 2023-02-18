---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.binds'
---Global keybinds that will apply anywhere, at anytime
---------------------------------------------------------------------------------

local apps = require("config.apps")
local app_launcher = require("ui.popups.app-launcher")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
local capi = { awesome = awesome, client = client } -- luacheck: ignore
-- -*-
local button, key = awful.button, awful.key
local super, alt, ctrl, shift = "Mod4", "Mod1", "Control", "Shift"
local lmb, mmb, rmb, scrollup, scrolldown = 1, 2, 3, 4, 5 -- luacheck: ignore

-------------------------------------------------------------------------------
awful.mouse.append_global_mousebindings({
  -- Todo the menu a
  button({}, lmb, function() end),
  button({}, scrollup, awful.tag.viewprev),
  button({}, scrolldown, awful.tag.viewnext),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  -- General awesomewm keys
  key({ super }, "F1", hotkeys_popup.show_help, { group = "Awesome", description = "Show Help" }),
  key({ super }, "w", function() end, { group = "Awesome", description = "Show Menu" }),
  key({ super, ctrl }, "r", capi.awesome.restart, { group = "Awesome", description = "Restart" }),
  key({ super, shift }, "q", function()
    require("ui.popups.exit-screen"):toggle()
  end, { group = "Awesome", description = "Exit screen " }),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  -- Launcher keys (or lauching programs keys)
  key({ super }, "p", function()
    app_launcher:toggle()
  end, { group = "Launcher", desc = "Open the Menubar" }),
  -- -*-
  key({ super }, "Return", function()
    awful.spawn(_G.terminal)
  end, { group = "Launcher", description = string.format("Terminal (%s)", _G.terminal) }),
  -- -*-
  key({ super, alt }, "c", function()
    awful.spawn(os.getenv("HOME") .. "/.local/bin/farge")
  end, { group = "Launcher", description = "Color Picker (farge)" }),
  -- -*-
  key({ super, shift }, "s", function()
    awful.spawn(apps.screenshot_tool)
  end, { group = "Launcher", description = "Screenshot Tool" }),
  -- -*-
  key({ super, shift }, "e", function()
    helpers.spawn.in_terminal("nvim")
  end, { group = "Launcher", description = "Editor (Neovim)" }),
  -- -*-
  key({ super, shift }, "a", function()
    helpers.spawn.in_terminal("mutt")
  end, { group = "Launcher", description = "Email Client (Neomutt)" }),
  -- -*-
  key({ super, alt }, "m", function()
    helpers.spawn.in_terminal("ncmpcpp")
  end, { group = "Launcher", description = "Music Player (ncmpcpp)" }),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  -- key({}, 'XF86XKAudioRaise', function() end, { group = 'Media', description = 'Raise Volume' }),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  -- Tag related keybindings. (windows-like)
  key({ super, ctrl }, "Left", awful.tag.viewprev, { group = "Tag", description = "View Previous" }),
  key({ super, ctrl }, "Right", awful.tag.viewnext, { group = "Tag", description = "View Next" }),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  key({ super }, "j", function()
    awful.client.focus.byidx(1)
  end, { group = "Client", description = "Focus Next (by index)" }),
  key({ super }, "k", function()
    awful.client.focus.byidx(-1)
  end, { group = "Client", description = "Focus Previous (by index)" }),
  -- -*-
  key({ super, ctrl }, "j", function()
    awful.screen.focus_relative(1)
  end, { group = "Screen", description = "Focus Next" }),
  key({ super, ctrl }, "k", function()
    awful.screen.focus_relative(-1)
  end, { group = "Screen", description = "Focus Previous" }),
  -- -*-
  key({ super, ctrl }, "n", function()
    local last_minimized_client = awful.client.restore()
    if last_minimized_client then
      last_minimized_client:activate({ raise = true, context = "key.unminimize" })
    end
  end, { group = "Client", description = "Restore Last Minimized" }),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  key({ super, shift }, "j", function()
    awful.client.swap.byidx(1)
  end, { group = "Client", description = "Swap with Next (by index)" }),
  key({ super, shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, { group = "Client", description = "Swap with Previous (by index)" }),
  -- -*-
  key({ super }, "u", awful.client.urgent.jumpto, { group = "Client", description = "Jump to Urgent" }),
  -- -*-
  key({ super }, "l", function()
    awful.tag.incmwfact(1 / 100)
  end, { group = "Layout", description = "Increase Master Width" }),
  key({ super }, "h", function()
    awful.tag.incmwfact(-1 / 100)
  end, { group = "Layout", description = "Decrease Master Width" }),
  -- -*-
  key({ super, shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { group = "Layout", description = "Increase Master Client number" }),
  key({ super, shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { group = "Layout", description = "Decrease Master Client number" }),
  -- -- -*-
  key({ super, ctrl }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { group = "Layout", description = "Increment Master Column number" }),
  key({ super, ctrl }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { group = "Layout", description = "Decrement Master Column number" }),
  -- -- -*-
  -- Managed otherwise
  -- key({ super }, 'space', function()
  --     awful.layout.inc(1)
  -- end, { group = 'Layout', description = 'Select Next' }),
  -- key({ super, shift }, 'space', function()
  --     awful.layout.inc(-1)
  -- end, { group = 'Layout', description = 'Select Previous' }),
  -- -- -*-
  key({ super, alt }, "b", function()
    local focused_screen_wibar = awful.screen.focused().wibar
    focused_screen_wibar.visible = not focused_screen_wibar.visible
  end, { group = "Layout", description = "Toggle Wibar (for focused screen) " }),
  -- -*-
  key({ super }, "Escape", function()
    require("naughty").destroy_all_notifications({ awful.screen.focused() })
  end, { group = "Tag", description = "Go Back" }),
})
-------------------------------------------------------------------------------
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { super },
    keygroup = "numrow",
    description = "View Tag",
    group = "Tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { super, ctrl },
    keygroup = "numrow",
    description = "Toggle Tag",
    group = "Tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { super, shift },
    keygroup = "numrow",
    description = "Move focused Client to Tag",
    group = "Tag",
    on_press = function(index)
      if capi.client.focus then
        local tag = capi.client.focus.screen.tags[index]
        if tag then
          capi.client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { super, shift, ctrl },
    keygroup = "numrow",
    description = "Toggle focused Client on Tag",
    group = "Tag",
    on_press = function(index)
      if capi.client.focus then
        local tag = capi.client.focus.screen.tags[index]
        if tag then
          capi.client.focus:toggle_tag(tag)
        end
      end
    end,
  }),
})
