---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.panels.info'
---------------------------------------------------------------------------------

local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gobject = require "gears.object"
local gtable = require "gears.table"
local gtimer = require "gears.timer"
local gshape = require "gears.shape"
local helpers = require "helpers"
local wibox = require "wibox"
local widgets = require "ui.widgets"
local theme_vars = beautiful.panels.info
-- -*-
local pulseaudio_daemon = require "daemons.hardware.pulseaudio"
local network_daemon = require "daemons.hardware.network"

local info_panel, instance = {}, nil

function info_panel:show()
  self.popup.screen = awful.screen.focused()
  self.popup.visible = true
  self.uptime_timer:again()
  self:emit_signal("visibility", true)
end

function info_panel:hide()
  self.popup.visible = false
  self.uptime_timer:stop()
  self:emit_signal("visibility", false)
end

function info_panel:toggle()
  if self.popup.visible then
    self:hide()
  else
    self:show()
  end
end

local function in_container(child)
  return widgets.container {
    forced_width = dpi(24),
    forced_height = dpi(24),
    bg = beautiful.colors.transparent,
    paddings = 0,
    margins = 0,
    child = child,
  }
end

local function user_area(self)
  local profile_image = wibox.widget {
    widget = wibox.widget.imagebox,
    image = require("gears.filesystem").get_configuration_dir() .. "/theme/profile.png",
    forced_height = theme_vars.profile_image_size,
    forced_width = theme_vars.profile_image_size,
    clip_shape = helpers.ui.rounded_rect(),
  }

  local user_icon = in_container(widgets.text {
    text = beautiful.icons.user.icon,
    font = beautiful.icons.user.font,
    color = beautiful.accent,
  })
  local user_greeting = widgets.text {
    text = string.format("%s@%s", os.getenv "USER", awesome.hostname),
    italic = true,
    halign = "left",
  }

  local user = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    user_icon,
    user_greeting,
  }

  local uptime_icon = in_container(widgets.text {
    text = beautiful.icons.clock.icon,
    font = beautiful.icons.clock.font,
    color = beautiful.accent,
  })
  local uptime_text = widgets.text {
    text = "uptime",
    halign = "left",
  }
  local uptime = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    uptime_icon,
    uptime_text,
  }

  self:connect_signal("uptime", function(_, uptime)
    uptime_text:set_text("Up: " .. uptime)
  end)

  return wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(12),
    profile_image,
    wibox.container.place({
      layout = wibox.layout.fixed.vertical,
      user,
      uptime,
    }, "left"),
  }
end

---Creates a button for the info panel.
---@param icon {icon:string, font:string}?
---@param image string?
---@param text string?
---@param on_main_press function
---@param on_advanced_press function?
---@param on_by_default boolean?
local function mkbutton(icon, on_main_press, on_advanced_press, on_by_default)
  local main_button, advanced_button, text_name

  local button_width = on_advanced_press ~= nil and theme_vars.button_width / 2 or theme_vars.button_width
  local main_button_shape = on_advanced_press ~= nil
      and function(cr, w, h)
        return gshape.partially_rounded_rect(cr, w, h, true, false, false, true, beautiful.corner_radius)
      end
    or helpers.ui.rounded_rect()

  if icon ~= nil then
    main_button = widgets.button.text.state {
      normal_fg = beautiful.accent,
      on_normal_fg = beautiful.colors.black,
      normal_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
      on_normal_bg = beautiful.accent,
      forced_height = theme_vars.button_height,
      forced_width = button_width,
      halign = "center",
      valign = "center",
      on_by_default = on_by_default,
      shape = main_button_shape,
      text = icon.icon,
      font = icon.font,
      on_press = function()
        on_main_press()
      end,
      on_turn_on = function()
        if advanced_button ~= nil then
          advanced_button:turn_on()
        end
      end,
      on_turn_off = function()
        if advanced_button ~= nil then
          advanced_button:turn_off()
        end
      end,
    }
  end

  if on_advanced_press ~= nil then
    advanced_button = widgets.button.text.state {
      normal_fg = beautiful.accent,
      on_normal_fg = beautiful.colors.black,
      normal_bg = beautiful.colors.black2 .. beautiful.opacity(0.5),
      on_normal_bg = beautiful.accent,
      halign = "center",
      valign = "center",
      forced_height = theme_vars.button_height,
      forced_width = button_width,
      on_by_default = on_by_default,
      shape = function(cr, w, h)
        return gshape.partially_rounded_rect(cr, w, h, false, true, true, false, beautiful.corner_radius)
      end,
      text = beautiful.icons.caret_right.icon,
      font = beautiful.icons.caret_right.font,
      on_press = function()
        on_advanced_press()
      end,
      -- Weird hack to not allow the advanced button to manage his own state, otherwise
      -- it wouldn't synchronized with the main button
      on_turn_on = function(self)
        self:turn_off()
      end,
      on_turn_off = function(self)
        self:turn_on()
      end,
    }
  end

  return wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(8),
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(2),
      main_button,
      advanced_button,
    },
  },
    main_button,
    advanced_button
end

local function system_controls(self)
  local wifi, wifi_button, wifi_advanced_button = mkbutton(beautiful.icons.wifi_high, function()
    network_daemon:toggle_wireless_state()
  end, function()
    require("ui.applets.wifi"):toggle(self.popup)
  end)

  local bluetooth = mkbutton(beautiful.icons.bluetooth, function()
    require("naughty").notify { text = "bluetooth toggle" }
  end, function()
    require("naughty").notify { text = "bluetooth applet" }
  end)

  local volume, volume_button, volume_advanced_button = mkbutton(beautiful.icons.volume_normal, function()
    pulseaudio_daemon:sink_toggle_mute(nil)
  end, function()
    require("ui.applets.audio"):toggle(self.popup)
  end)

  -- Update signals for icons.
  pulseaudio_daemon:connect_signal("sinks::default::updated", function(_, sink)
    if sink.mute == true or sink.volume == 0 then
      volume_button:turn_off()
      volume_advanced_button:turn_off()
    else
      volume_button:turn_on()
      volume_advanced_button:turn_on()
    end
    if sink.mute or sink.volume == 0 then
      volume_button:set_text(beautiful.icons.volume_off.icon)
    elseif sink.volume <= 33 then
      volume_button:set_text(beautiful.icons.volume_low.icon)
    elseif sink.volume <= 66 then
      volume_button:set_text(beautiful.icons.volume_normal.icon)
    elseif sink.volume > 66 then
      volume_button:set_text(beautiful.icons.volume_high.icon)
    end
  end)
  -- -*-
  network_daemon:connect_signal("wireless_state", function(_, state)
    if state == false then
      wifi_button:turn_off()
      wifi_advanced_button:turn_off()
    else
      wifi_button:turn_on()
      wifi_advanced_button:turn_on()
    end
  end)
  network_daemon:connect_signal("access_point::connected", function(_, _, strength)
    if strength < 33 then
      wifi_button:set_text(beautiful.icons.wifi_low.icon)
    elseif strength >= 33 then
      wifi_button:set_text(beautiful.icons.wifi_medium.icon)
    elseif strength >= 66 then
      wifi_button:set_text(beautiful.icons.wifi_high.icon)
    end
  end)

  return wibox.widget {
    layout = wibox.layout.grid,
    spacing = dpi(12),
    -- forced_num_rows = 3,
    forced_num_cols = 3,
    wifi,
    bluetooth,
    volume,
  }
end

local function misc_buttons(self)
  local power_button = widgets.button.text.normal {
    normal_bg = beautiful.colors.transparent,
    hover_bg = beautiful.colors.transparent,
    normal_fg = beautiful.accent,
    forced_height = dpi(24),
    forced_width = dpi(24),
    font = beautiful.icons.poweroff.font,
    text = beautiful.icons.poweroff.icon,
    size = 12,
    halign = "center",
    valign = "center",
    on_press = function()
      require("ui.screens.power"):show()
    end,
  }

  return wibox.widget {
    layout = wibox.layout.align.horizontal,
    power_button,
  }
end

local function content(self)
  return wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(12),
    user_area(self),
    widgets.separator {
      orientation = "horizontal",
      thickness = dpi(1),
      forced_height = dpi(1),
      forced_width = dpi(1),
    },
    system_controls(self),
    misc_buttons(self),
  }
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, info_panel, true)

  ret.uptime_timer = gtimer {
    timeout = 1,
    call_now = true,
    autostart = false,
    single_shot = false,
    callback = function()
      awful.spawn.easy_async("uptime", function(stdout)
        stdout = stdout:match "^.*up(.-),"
        stdout = stdout:gsub(",%s*(.-)%s*$", "%1")

        stdout = stdout:gsub("^%s*(.-)%s*$", "%1")
        -- Very inneficient way to pass the values to the user_area, but eh
        -- thats all we have
        ret:emit_signal("uptime", stdout)
      end)
    end,
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
        content(ret),
      },
    },
  }

  helpers.ui.hide_on_outside_click(ret)
  helpers.ui.hide_on_tag_change(ret)

  return ret
end

instance = instance or new()
return instance
