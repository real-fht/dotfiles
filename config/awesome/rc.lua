---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'rc'
---------------------------------------------------------------------------------

-- If I (by any chance) install some luarocks packages, try to load them.
-- This also ensures that updated version of LGI are loaded, if they are installed.
pcall(require, "luarocks.loader")

-- Init libraries.
local beautiful = require "beautiful"
local gtimer = require "gears.timer"

-- Handle errors asap.
local naughty = require "naughty"
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  }
end)

collectgarbage("setpause", 100)
collectgarbage("setstepmul", 400)

-- Theme variables definitions, accessible from the beautiful object.
beautiful.init(require "theme")

-- Basic AwesomeWM configuration.
require "config"

-- Beautify AwesomeWM in every way possible!
require "ui"

-- Periodically collect garbage.
gtimer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage "collect"
  end,
}
