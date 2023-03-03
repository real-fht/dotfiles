---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'modules.icon_theme'
---Simplified interface to the Gtk3 Icon theme class.
---------------------------------------------------------------------------------

-- Documentation can be found at the following GTK developer documentation url:
-- https://docs.gtk.org/gtk3/index.html

local lgi = require "lgi"
local Gio = lgi.Gio
local Gtk3 = lgi.require("Gtk", "3.0")
local gobject = require "gears.object"
local gtable = require "gears.table"
local ipairs = ipairs

local name_lookup = {
  ["telegram-desktop"] = "telegram",
}

local icon_theme, instance = {}, nil

local function get_icon_by_pid_command(self, c, apps)
  local pid = c.pid
  if pid ~= nil then
    local handle = io.popen(string.format("ps -p %d -o comm=", pid))
    local pid_command = handle:read("*a"):gsub("^%s*(.-)%s*$", "%1")
    handle:close()

    for _, app in ipairs(apps) do
      local executable = app:get_executable()
      if executable and executable:find(pid_command, 1, true) then
        return self:get_gicon_path(app:get_icon())
      end
    end
  end
end

local function get_icon_by_icon_name(self, c, apps)
  local icon_name = c.icon_name and c.icon_name:lower() or nil
  if icon_name ~= nil then
    for _, app in ipairs(apps) do
      local name = app:get_name():lower()
      if name and name:find(icon_name, 1, true) then
        return self:get_gicon_path(app:get_icon())
      end
    end
  end
end

local function get_icon_by_class(self, c, apps)
  if c.class ~= nil then
    local class = name_lookup[c.class] or c.class:lower()

    -- Try to remove dashes
    local class_1 = class:gsub("[%-]", "")

    -- Try to replace dashes with dot
    local class_2 = class:gsub("[%-]", ".")

    -- Try to match only the first word
    local class_3 = class:match "(.-)-" or class
    class_3 = class_3:match "(.-)%." or class_3
    class_3 = class_3:match "(.-)%s+" or class_3

    local possible_icon_names = { class, class_3, class_2, class_1 }
    for _, app in ipairs(apps) do
      local id = app:get_id():lower()
      for _, possible_icon_name in ipairs(possible_icon_names) do
        if id and id:find(possible_icon_name, 1, true) then
          return self:get_gicon_path(app:get_icon())
        end
      end
    end
  end
end

function icon_theme:get_client_icon_path(c)
  local apps = Gio.AppInfo.get_all()

  return get_icon_by_pid_command(self, c, apps)
    or get_icon_by_icon_name(self, c, apps)
    or get_icon_by_class(self, c, apps)
    or c.icon
    or self:choose_icon { "window", "window-manager", "xfwm4-default", "window_list" }
end

function icon_theme:choose_icon(icons_names)
  local icon_info = self.GtkIconTheme:choose_icon(icons_names, self.icon_size, 0)
  if icon_info then
    local icon_path = icon_info:get_filename()
    if icon_path then
      return icon_path
    end
  end

  return ""
end

function icon_theme:get_gicon_path(gicon)
  if gicon == nil then
    return ""
  end

  local icon_info = self.GtkIconTheme:lookup_by_gicon(gicon, self.icon_size, 0)
  if icon_info then
    local icon_path = icon_info:get_filename()
    if icon_path then
      return icon_path
    end
  end

  return ""
end

function icon_theme:get_icon_path(icon_name)
  -- https://docs.gtk.org/gtk3/method.IconTheme.lookup_icon.html
  local icon_info = self.GtkIconTheme:lookup_icon(icon_name, self.icon_size, 0)
  if icon_info then
    -- Get the appropriate filename for the icon
    local icon_path = icon_info:get_filename()
    if icon_path then
      return icon_path
    end
  end

  return ""
end

local function new(theme_name, icon_size)
  local obj = gobject {}
  gtable.crush(obj, icon_theme, true)

  obj.name = theme_name or nil
  obj.icon_size = icon_size or 48

  if theme_name then
    obj.GtkIconTheme = Gtk3.IconTheme.new()
    Gtk3.IconTheme.set_custom_theme(obj.GtkIconTheme, theme_name)
  else
    -- The get default theme is basically a way to reference the currently
    -- set icon theme system-wide (set using lxappearance or something similar)
    obj.GtkIconTheme = Gtk3.IconTheme.get_default()
  end

  return obj
end

---@class IconThemeModule
---@field get_icon_path function
---@field get_gicon_path function
---@field choose_icon function
---@field get_client_icon_path function

---@type IconThemeModule
instance = instance or new()
return instance
