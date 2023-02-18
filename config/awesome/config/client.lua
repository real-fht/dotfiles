---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'config.client'
---Configuration for how AwesomeWM should manage and work with clients
---------------------------------------------------------------------------------

local awful = require("awful")
local rclient = require("ruled.client")
local capi = { awesome = awesome, client = client } -- luacheck: ignore
-- -*-
local button, key = awful.button, awful.key
local super, alt, ctrl, shift = "Mod4", "Mod1", "Control", "Shift"
local lmb, mmb, rmb, scrollup, scrolldown = 1, 2, 3, 4, 5 -- luacheck: ignore

-------------------------------------------------------------------------------
capi.client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    button({ super }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    button({ super }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)
-------------------------------------------------------------------------------
capi.client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    key({ super }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { group = "Client", description = "Toggle fullscreen" }),
    key({ super, shift }, "c", function(c)
      c:kill()
    end, { group = "Client", description = "Close" }),
    key({ super, ctrl }, "space", awful.client.floating.toggle, { group = "Client", description = "Toggle floating" }),
    key({ super, ctrl }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, { group = "Client", description = "Move to Master" }),
    key({ super }, "o", function(c)
      c:move_to_screen()
    end, { group = "Client", description = "Move to Screen" }),
    key({ super }, "t", function(c)
      c.ontop = not c.ontop
    end, { group = "Client", description = "Toggle ontop" }),
    key({ super }, "n", function(c)
      c.minimized = true
    end, { group = "Client", description = "Minimize" }),

    awful.key({ super }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { group = "Client", description = "Toggle maximized" }),
    awful.key({ super, ctrl }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, { group = "Client", description = "Toggle vertical maximized" }),
    awful.key({ super, shift }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, { group = "Client", description = "Toggle horizontal maximized" }),

    awful.key({ super, alt }, "t", function(c)
      c.titlebar:toggle()
    end, { group = "Client", description = "Toggle Titlebar" }),
  })
end)
-------------------------------------------------------------------------------
rclient.connect_signal("request::rules", function()
  -- By default, all the new clients should spawn on the selected screen, while
  -- also trying their best to not overlap over other ones.
  rclient.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- Add titlebars for normal windows and dialogs
  rclient.append_rule({
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  })

  -- Chatting apps should be on the 3rd workspace.
  rclient.append_rule({
    id = "chatting_apps",
    rule_any = { class = { "discord", "WebCord", "TelegramDesktop" } },
    properties = {
      screen = awful.screen.focused(),
      tag = awful.screen.focused().tags[3],
    },
  })

  -- Office and other stuff.
  rclient.append_rule({
    id = "office_apps",
    rule_any = { class = { "libreoffice-startcenter" } },
    properties = {
      tag = awful.screen.focused().tags[5],
      floating = true,
      placement = awful.placement.centered,
      width = function()
        return awful.screen.focused().geometry.width / 2
      end,
      height = function()
        return awful.screen.focused().geometry.height / 2
      end,
    },
  })

  -- Games, they should be floating by default (since most of them run through
  -- wine in a smaller resolution than the screen)
  rclient.append_rule({
    id = "games",
    rule_any = {
      class = {
        "Celeste.bin.x86_64",
        "Steam",
        "steam_app_*",
        "osu!.exe",
        "Grapejuice",
        "minecraft-launcher",
        "Etterna",
        "PrismLauncher",
      },
      name = { "Roblox" },
    },
    properties = {
      floating = true,
      titlebars_enabled = false, -- No need fr
      placement = awful.placement.centered,
      tag = awful.screen.focused().tags[6],
    },
  })

  -- Just floating stuff.
  rclient.append_rule({
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = { "Sxiv", "Lxappearance", "KeePassXC", "mpv" },
      name = { "Event Tester" }, -- xev.
    },
    properties = { floating = true },
  })

  -- Floating centered stuff.
  rclient.append_rule({
    id = "floating_center",
    rule_any = {
      class = {
        "lxappearance",
        "TelegramDesktop",
        "Lxappearance",
        "Pavucontrol",
        "Virt-manager",
        "KeePassXC",
        "love",
      },
      name = { "Olympus" },
    },
    properties = { floating = true, placement = awful.placement.centered },
  })

  -- I like the clean effect of having my editor entered.
  -- rclient.append_rule {
  --     id = 'centered_neovide',
  --     rule = { class = 'neovide' },
  --     properties = {
  --         floating = true,
  --         placement = awful.placement.centered,
  --         width = dpi(960),
  --         height = dpi(640),
  --     },
  -- }

  -- I always want my browsers to be on the 2nd workspace.
  rclient.append_rule({
    id = "web_browsers",
    rule_any = { class = { "qutebrowser", "librewolf" } },
    properties = {
      tag = function()
        -- Change what the focused screen dynamically
        return awful.screen.focused().tags[2]
      end,
    },
  })

  rclient.append_rule({
    id = "media_tools",
    rule_any = { class = { "Shotcut" } },
    properties = {
      tag = function()
        return awful.screen.focused().tags[5]
      end,
    },
  })

  -- Custom titlebar for music clients
  rclient.append_rule({
    id = "music_player",
    rule = { class = "music", instance = "music" },
    callback = function(c)
      require("ui.decorations.ncmpcpp")(c)
    end,
    properties = {
      floating = true,
      placement = awful.placement.centered,
      height = awful.screen.focused().geometry.height / math.sqrt(2),
      width = awful.screen.focused().geometry.width / math.sqrt(3),
    },
  })
end)
-------------------------------------------------------------------------------
-- This is for proper icon management.
-- local icon_cache = {}
-- capi.client.connect_signal('manage', function(c)
--     local icon = menubar.utils.lookup_icon(c.instance)
--     local lower_icon = menubar.utils.lookup_icon(c.instance:lower())
--
--     -- Use the cache if icon already exists.
--     if icon_cache[c.instance] ~= nil then
--         c.icon = icon_cache[c.instance]
--     elseif icon ~= nil then
--         local raw_icon = gsurface(icon)
--         c.icon = raw_icon._native
--         icon_cache[c.instance] = raw_icon._native
--     elseif lower_icon ~= nil then
--         -- Otherwise check if it exists using the lowercase name
--         local raw_icon = gsurface(lower_icon)
--         c.icon = raw_icon._native
--         icon_cache[c.instance] = raw_icon._native
--
--         --Check if the client already has an icon. If not, give it a default.
--     elseif c.icon == nil then
--         local raw_icon = gsurface(menubar.utils.lookup_icon 'application-default-icon')
--         c.icon = raw_icon._native
--     end
--
--     -- c.shape = helpers.ui.rounded_rect(8)
-- end)
-------------------------------------------------------------------------------
-- Enable window swallowing, helps with child clients opened from a terminal
require("modules.bling").module.window_swallowing.start()
-------------------------------------------------------------------------------
-- Enable sloppy focus, so that focus follows mouse.
capi.client.connect_signal("mouse::enter", function(c)
  c:activate({ context = "mouse_enter", raise = false })
end)
