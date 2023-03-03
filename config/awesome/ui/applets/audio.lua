---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.applets.audio'
---------------------------------------------------------------------------------

local animation = require "modules.animation"
local awful = require "awful"
local beautiful = require "beautiful"
local icon_theme = require "modules.icon_theme"
local dpi = beautiful.xresources.apply_dpi
local gobject = require "gears.object"
local gshape = require "gears.shape"
local gtable = require "gears.table"
local helpers = require "helpers"
local wibox = require "wibox"
local widgets = require "ui.widgets"
-- -*-
local pulseaudio_daemon = require "daemons.hardware.pulseaudio"

local applet, instance = {}, nil

function applet:show(next_to)
  self.popup.screen = awful.screen.focused()
  self.popup:move_next_to(next_to)
  self.popup.visible = true
  self:emit_signal("visibility", true)
end

function applet:hide()
  self.popup.visible = false
  self:emit_signal("visibility", false)
end

function applet:toggle(next_to)
  if self.popup.visible then
    self:hide()
  else
    self:show(next_to)
  end
end

---@class DeviceWidgetArgs
---@field type string
---@field device table
---@field icon {font:string, icon:string}
---@field icon_mute {font:string, icon:string}
---@field on_mute_press function
---@field on_default_press function
---@field on_slider_moved function
---@field on_removed_cb function

---@param args DeviceWidgetArgs
local function device_widget(args)
  local device_name = widgets.text {
    halign = "left",
    size = 12,
    text = args.device.description,
  }

  local device_volume_icon = widgets.button.text.normal {
    font = args.icon.font,
    text = args.icon_mute.icon,
    normal_fg = beautiful.accent,
    normal_bg = beautiful.colors.transparent,
    hover_effect = false,
    press_effect = false,
    forced_height = dpi(24),
    forced_width = dpi(24),
    halign = "center",
    on_press = function()
      args.on_mute_press()
    end,
  }

  local device_default_checkbox = widgets.button.text.state {
    on_by_default = args.device.default,
    normal_fg = beautiful.colors.grey,
    on_normal_fg = beautiful.colors.green,
    normal_bg = beautiful.colors.transparent,
    on_normal_bg = beautiful.colors.transparent,
    hover_effect = false,
    press_effect = false,
    font = beautiful.icons.check.font,
    text = beautiful.icons.check.icon,
    forced_height = dpi(24),
    halign = "center",
    forced_width = dpi(24),
    size = 12,
    on_press = function()
      args.on_default_press()
    end,
  }

  local device_volume_slider = wibox.widget {
    widget = wibox.widget.slider,
    handle_shape = gshape.circle,
    handle_color = beautiful.accent,
    handle_width = beautiful.audio_applet_volume_slider_height + dpi(6),
    bar_height = beautiful.audio_applet_volume_slider_height,
    shape = helpers.ui.rounded_rect(),
    bar_shape = helpers.ui.rounded_rect(),
    value = args.device.volume,
    maximum = 100,
    minumum = 0,
    bar_color = beautiful.colors.onebg .. beautiful.opacity(0.5),
    bar_active_color = beautiful.accent,
  }

  local widget = wibox.widget {
    widget = wibox.container.margin,
    {
      layout = wibox.layout.fixed.vertical,
      forced_height = dpi(50),
      {
        layout = wibox.layout.align.horizontal,
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(6),
          device_volume_icon,
          device_name,
        },
        nil,
        device_default_checkbox,
      },
      device_volume_slider,
    },
  }

  pulseaudio_daemon:connect_signal(string.format("%s::%s::removed", args.type, args.device.id), function()
    args.on_removed_cb(widget)
  end)

  pulseaudio_daemon:connect_signal(string.format("%s::%s::updated", args.type, args.device.id), function(_, device)
    device_volume_slider:set_value_instant(device.volume)
    if device.default then
      device_default_checkbox:turn_on()
    else
      device_default_checkbox:turn_off()
    end

    if device.mute or device.volume == 0 then
      device_volume_icon:set_text(args.icon_mute.icon)
    else
      device_volume_icon:set_text(args.icon.icon)
    end
  end)

  device_volume_slider:connect_signal("property::value", function(_, value, instant)
    if instant == false then
      args.on_slider_moved(value)
    end
  end)

  return widget
end

---@class ApplicationWidgetArgs
---@field type string
---@field application table
---@field icon {font:string, icon:string}
---@field icon_mute {font:string, icon:string}
---@field on_mute_press function
---@field on_slider_moved function
---@field on_removed_cb function

---@param args ApplicationWidgetArgs
local function application_widget(args)
  local application_name = widgets.text {
    halign = "left",
    size = 12,
    text = args.application.name,
  }

  local application_icon = wibox.widget {
    widget = wibox.widget.imagebox,
    halign = "center",
    valign = "center",
    forced_height = dpi(24),
    forced_width = dpi(24),
    image = icon_theme:choose_icon {
      args.application.name or args.application.icon_name,
      "gnome-audio",
    },
  }

  local application_volume_icon = widgets.button.text.normal {
    font = beautiful.icon_font_name,
    normal_fg = beautiful.accent,
    normal_bg = beautiful.colors.transparent,
    hover_effect = false,
    press_effect = false,
    forced_height = dpi(24),
    forced_width = dpi(24),
    halign = "center",
    on_press = function()
      args.on_mute_press()
    end,
  }

  local application_volume_slider = wibox.widget {
    widget = wibox.widget.slider,
    handle_shape = gshape.circle,
    handle_color = beautiful.accent,
    handle_width = beautiful.audio_applet_volume_slider_height + dpi(6),
    -- forced_width = beautiful.volume_osd_bar_width,
    -- forced_height = beautiful.volume_osd_bar_height,
    bar_height = beautiful.audio_applet_volume_slider_height,
    shape = helpers.ui.rounded_rect(),
    bar_shape = helpers.ui.rounded_rect(),
    value = args.application.volume,
    maximum = 100,
    minumum = 0,
    bar_color = beautiful.colors.onebg .. beautiful.opacity(0.5),
    bar_active_color = beautiful.accent,
  }

  local widget = wibox.widget {
    widget = wibox.container.margin,
    {
      layout = wibox.layout.fixed.vertical,
      forced_height = dpi(50),
      {
        layout = wibox.layout.align.horizontal,
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(6),
          application_icon,
          application_name,
        },
        nil,
        application_volume_icon,
      },
      application_volume_slider,
    },
  }

  pulseaudio_daemon:connect_signal(string.format("%s::%s::removed", args.type, args.application.id), function()
    args.on_removed_cb(widget)
  end)

  pulseaudio_daemon:connect_signal(string.format("%s::%s::updated", args.type, args.application.id), function(_, app)
    application_volume_slider:set_value_instant(app.volume)

    if app.mute or app.volume == 0 then
      application_volume_icon:set_text(args.icon_mute.icon)
    else
      application_volume_icon:set_text(args.icon.icon)
    end
  end)

  application_volume_slider:connect_signal("property::value", function(_, value, instant)
    if instant == false then
      args.on_slider_moved(value)
    end
  end)

  return widget
end

local function applications()
  local sink_inputs_header = widgets.text {
    size = 12,
    color = beautiful.accent,
    text = "Sink Inputs",
    bold = true,
  }

  local sink_inputs_layout = wibox.widget {
    layout = require("wibox.layout.overflow").vertical,
    forced_height = dpi(200),
    spacing = beautiful.audio_applet_item_spacing,
    scrollbar_widget = {
      widget = wibox.widget.separator,
      color = beautiful.colors.onebg,
      shape = helpers.ui.rounded_rect(),
    },
    scrollbar_width = dpi(2),
    step = 50,
  }

  pulseaudio_daemon:connect_signal("sink_inputs::added", function(_, sink_input)
    sink_inputs_layout:add(application_widget {
      type = "sink_inputs",
      application = sink_input,
      icon = beautiful.icons.volume_high,
      icon_mute = beautiful.icons.volume_off,
      on_mute_press = function()
        pulseaudio_daemon:sink_input_toggle_mute(sink_input.id)
      end,
      on_slider_moved = function(volume)
        pulseaudio_daemon:sink_input_set_volume(sink_input.id, volume)
      end,
      on_removed_cb = function(widget)
        sink_inputs_layout:remove_widgets(widget)
      end,
    })
  end)

  local source_outputs_header = widgets.text {
    size = 12,
    color = beautiful.accent,
    text = "Source Outputs",
    bold = true,
  }

  local source_outputs_layout = wibox.widget {
    layout = require("wibox.layout.overflow").vertical,
    forced_height = dpi(200),
    spacing = beautiful.audio_applet_item_spacing,
    scrollbar_widget = {
      widget = wibox.widget.separator,
      color = beautiful.colors.onebg,
      shape = helpers.ui.rounded_rect(),
    },
    scrollbar_width = dpi(2),
    step = 50,
  }

  pulseaudio_daemon:connect_signal("source_outputs::added", function(_, source_output)
    source_outputs_layout:add(application_widget {
      type = "source_outputs",
      application = source_output,
      icon = beautiful.icons.microphone,
      icon_mute = beautiful.icons.microphone_off,
      on_mute_press = function()
        pulseaudio_daemon:source_output_toggle_mute(source_output.id)
      end,
      on_slider_moved = function(volume)
        pulseaudio_daemon:source_output_set_volume(source_output.id, volume)
      end,
      on_removed_cb = function(widget)
        source_outputs_layout:remove_widgets(widget)
      end,
    })
  end)

  return wibox.widget {
    layout = wibox.layout.fixed.vertical,
    {
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(8),
      sink_inputs_header,
      widgets.separator {
        orientation = "horizontal",
        forced_height = dpi(2),
      },
      sink_inputs_layout,
    },
    helpers.ui.vertical_padding(dpi(12)),
    {
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(8),
      source_outputs_header,
      widgets.separator {
        orientation = "horizontal",
        forced_height = dpi(2),
      },
      source_outputs_layout,
    },
  }
end

local function devices()
  local sinks_header = widgets.text {
    size = 12,
    color = beautiful.accent,
    text = "Sinks",
    bold = true,
  }

  local sinks_layout = wibox.widget {
    layout = require("wibox.layout.overflow").vertical,
    forced_height = dpi(200),
    spacing = beautiful.audio_applet_item_spacing,
    scrollbar_widget = {
      widget = wibox.widget.separator,
      color = beautiful.colors.onebg,
      shape = helpers.ui.rounded_rect(),
    },
    scrollbar_width = dpi(2),
    step = 50,
  }

  pulseaudio_daemon:connect_signal("sinks::added", function(_, sink)
    sinks_layout:add(device_widget {
      type = "sinks",
      device = sink,
      icon = beautiful.icons.volume_high,
      icon_mute = beautiful.icons.volume_off,
      on_mute_press = function()
        pulseaudio_daemon:sink_toggle_mute(sink.id)
      end,
      on_default_press = function()
        pulseaudio_daemon:set_default_sink(sink.id)
      end,
      on_slider_moved = function(volume)
        pulseaudio_daemon:sink_set_volume(sink.id, volume)
      end,
      on_removed_cb = function(widget)
        sinks_layout:remove_widgets(widget)
      end,
    })
  end)

  local sources_header = widgets.text {
    size = 12,
    color = beautiful.accent,
    text = "Sources",
    bold = true,
  }

  local sources_layout = wibox.widget {
    layout = require("wibox.layout.overflow").vertical,
    forced_height = dpi(200),
    spacing = beautiful.audio_applet_item_spacing,
    scrollbar_widget = {
      widget = wibox.widget.separator,
      color = beautiful.colors.onebg,
      shape = helpers.ui.rounded_rect(),
    },
    scrollbar_width = dpi(2),
    step = 50,
  }

  pulseaudio_daemon:connect_signal("sources::added", function(_, source)
    sources_layout:add(device_widget {
      type = "sources",
      device = source,
      icon = beautiful.icons.microphone,
      icon_mute = beautiful.icons.microphone_off,
      on_mute_press = function()
        pulseaudio_daemon:source_toggle_mute(source.id)
      end,
      on_default_press = function()
        pulseaudio_daemon:set_default_source(source.id)
      end,
      on_slider_moved = function(volume)
        pulseaudio_daemon:source_set_volume(source.id, volume)
      end,
      on_removed_cb = function(widget)
        sinks_layout:remove_widgets(widget)
      end,
    })
  end)

  return wibox.widget {
    layout = wibox.layout.fixed.vertical,
    {
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(8),
      sinks_header,
      widgets.separator {
        orientation = "horizontal",
        forced_height = dpi(2),
      },
      sinks_layout,
    },
    helpers.ui.vertical_padding(dpi(12)),
    {
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(8),
      sources_header,
      widgets.separator {
        orientation = "horizontal",
        forced_height = dpi(2),
      },
      sources_layout,
    },
  }
end

local function content(self)
  local devices_content = devices()
  local applications_content = applications()

  local stack = wibox.widget {
    layout = wibox.layout.stack,
    top_only = true, -- Only show the active area.
    devices_content,
    applications_content,
  }

  -- Hacky way to setup buttons since I need to turn off the buttons mutually
  -- (when devices is clicked, applications gets turned off, and vice-versa)
  local buttons = {}
  buttons.devices = widgets.button.text.state {
    normal_bg = beautiful.colors.transparent,
    on_normal_bg = beautiful.audio_applet_button_bg,
    normal_fg = beautiful.colors.white,
    on_normal_fg = beautiful.accent,
    on_by_default = true,
    forced_width = dpi(300),
    paddings = dpi(12),
    text = "Devices",
    bold = true,
    halign = "center",
    on_turn_on = function()
      buttons.applications:turn_off()
      stack:raise_widget(devices_content)
    end,
  }
  buttons.applications = widgets.button.text.state {
    normal_bg = beautiful.colors.transparent,
    on_normal_bg = beautiful.audio_applet_button_bg,
    normal_fg = beautiful.colors.white,
    on_normal_fg = beautiful.accent,
    paddings = dpi(12),
    forced_width = dpi(300),
    text = "Applications",
    bold = true,
    halign = "center",
    on_turn_on = function()
      buttons.devices:turn_off()
      stack:raise_widget(applications_content)
    end,
  }

  return wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(12),
    {
      layout = wibox.layout.flex.horizontal,
      spacing = dpi(6),
      fill_space = true,
      buttons.devices,
      buttons.applications,
    },
    {
      widget = wibox.container.margin,
      margins = beautiful.audio_applet_paddings / 2,
      stack,
    },
  }
end

local function new()
  local ret = gobject {}
  gtable.crush(ret, applet, true)

  ret.popup = awful.popup {
    bg = beautiful.colors.transparent,
    shape = gshape.rectangle,
    ontop = true,
    visible = false,
    minimum_width = dpi(500),
    maximum_width = dpi(500),
    forced_height = dpi(12),
    -- placement = function(c)
    --   awful.placement.bottom_right(c, {
    --     honor_workarea = true,
    --     margins = { right = beautiful.useless_gap, bottom = beautiful.useless_gap },
    --   })
    -- end,
    widget = wibox.widget {
      widget = wibox.container.background,
      bg = beautiful.audio_applet_bg,
      {
        widget = wibox.container.margin,
        margins = beautiful.audio_applet_paddings,
        content(ret),
      },
    },
  }

  return ret
end

instance = instance or new()
return instance
