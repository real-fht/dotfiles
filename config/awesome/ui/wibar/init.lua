---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.wibar'
---------------------------------------------------------------------------------

local animation = require "modules.animation"
local awful = require "awful"
local beautiful = require "beautiful"
local gshape = require "gears.shape"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"
local icon_theme = require "modules.icon_theme"
local wibox = require "wibox"
local widgets = require "ui.widgets"
-- -*-
local calendar_popup = require "ui.popups.calendar"
local systray_popup = require "ui.popups.systray"
local info_panel = require "ui.panels.info"
-- -*-
local upower_daemon = require "daemons.hardware.upower"
local pulseaudio_daemon = require "daemons.hardware.pulseaudio"
local network_daemon = require "daemons.hardware.network"

local USABLE_WIBAR_HEIGHT = (function()
  if type(beautiful.wibar.paddings) == "number" then
    return beautiful.wibar.height - (beautiful.wibar.paddings * 2)
  else
    return beautiful.wibar.height - beautiful.wibar.paddings.top - beautiful.wibar.paddings.bottom
  end
end)()

local function layoutbox(s)
  return widgets.button.basic.normal {
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.wibar.item_bg,
    press_bg = beautiful.wibar.item_bg,
    forced_height = USABLE_WIBAR_HEIGHT,
    forced_width = USABLE_WIBAR_HEIGHT,
    paddings = dpi(6),
    child = awful.widget.layoutbox { screen = s },
    on_press = function()
      require("ui.popups.layout-picker"):toggle()
    end,
  }
end

local function taglist(s)
  local theme_vars = beautiful.wibar.taglist
  local function update_tag_look(self, tag)
    local targets = {}
    if tag.selected then
      targets.color = theme_vars.item_color_focus
      targets.width = theme_vars.item_width_focus
    elseif tag.urgent then
      targets.color = theme_vars.item_color_urgent
      targets.width = theme_vars.item_width_urgent
    elseif #tag:clients() > 0 then
      targets.color = theme_vars.item_color_occupied
      targets.width = theme_vars.item_width_occupied
    else
      targets.color = theme_vars.item_color_normal
      targets.width = theme_vars.item_width_normal
    end

    self.indicator_animation:set {
      color = helpers.color.hex_to_rgba(targets.color),
      width = targets.width,
    }
  end

  return widgets.container {
    bg = beautiful.wibar.item_bg,
    forced_height = USABLE_WIBAR_HEIGHT,
    paddings = dpi(6),
    child = awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      layout = { layout = wibox.layout.fixed.horizontal, spacing = theme_vars.item_spacing },
      widget_template = {
        widget = wibox.container.background,
        forced_height = theme_vars.item_height,
        create_callback = function(self, tag, _, _)
          local indicator = widgets.button.basic.normal {
            forced_height = theme_vars.item_height,
            forced_width = theme_vars.item_width_normal,
            normal_bg = theme_vars.item_color_normal,
            hover_effect = false,
            on_hover = function()
              if #tag:clients() > 0 and not tag.selected then
                awesome.emit_signal("bling::tag_preview::update", tag)
                awesome.emit_signal("bling::tag_preview::visibility", s, true)
              end
            end,
            on_leave = function()
              awesome.emit_signal("bling::tag_preview::visibility", s, false)
            end,
            shape = helpers.ui.rounded_rect(dpi(8)),
          }
          self.indicator_animation = animation:new {
            pos = {
              color = helpers.color.hex_to_rgba(theme_vars.item_color_normal),
              width = theme_vars.item_width_normal,
            },
            duration = 1 / 8,
            easing = animation.easing.linear,
            update = function(_, pos)
              indicator:set_bg(helpers.color.rgba_to_hex(pos.color))
              indicator:set_width(pos.width)
            end,
          }
          self:set_widget(indicator)
          update_tag_look(self, tag)
        end,
        update_callback = update_tag_look,
      },
    },
  }
end

local function tasklist(s)
  local theme_vars = beautiful.wibar.tasklist
  local function update_client_look(self, c)
    local targets = {}

    if c.active then
      -- Indicator
      targets.width = theme_vars.indicator_width_focus
      targets.color = theme_vars.indicator_color_focus
      -- Container
      self.icon_container:turn_on()
    elseif c.urgent then
      -- Indicator
      targets.width = theme_vars.indicator_width_urgent
      targets.color = theme_vars.indicator_color_urgent
      -- Container
      self.icon_container:turn_on()
    elseif c.minimized then
      -- Indicator
      targets.width = theme_vars.indicator_width_minimized
      targets.color = theme_vars.indicator_color_minimized
      -- Container
      self.icon_container:turn_off()
    else
      -- The default.
      targets.width = theme_vars.indicator_width_normal
      targets.color = theme_vars.indicator_color_normal
      -- Container
      self.icon_container:turn_off()
    end

    self.icon_indicator_animation:set {
      width = targets.width,
      color = helpers.color.hex_to_rgba(targets.color),
    }
  end

  return widgets.container {
    bg = beautiful.wibar.item_bg, -- the items will have black2 bg
    forced_height = USABLE_WIBAR_HEIGHT,
    paddings = 0,
    child = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      layout = {
        layout = wibox.layout.fixed.horizontal,
        spacing = theme_vars.item_spacing,
      },
      widget_template = {
        widget = wibox.container.background,
        forced_height = USABLE_WIBAR_HEIGHT,
        forced_width = USABLE_WIBAR_HEIGHT,
        halign = "center",
        valign = "center",
        create_callback = function(self, c, index, clients)
          self.icon_container = widgets.button.basic.state {
            normal_bg = theme_vars.item_bg_normal,
            on_normal_bg = theme_vars.item_bg_focus,
            on_by_default = c.focus,
            forced_height = USABLE_WIBAR_HEIGHT,
            forced_width = USABLE_WIBAR_HEIGHT,
          }

          local icon_indicator = widgets.container {
            shape = gshape.rounded_bar,
            forced_height = dpi(2),
            forced_width = theme_vars.indicator_width_normal,
            valign = "bottom",
            bg = theme_vars.indicator_color_normal,
          }

          self.icon_indicator_animation = animation:new {
            duration = 1 / 8,
            easing = animation.easing.linear,
            pos = {
              color = helpers.color.hex_to_rgba(theme_vars.indicator_color_normal),
              width = theme_vars.indicator_width_normal,
            },
            update = function(_, pos)
              icon_indicator:set_bg(helpers.color.rgba_to_hex(pos.color))
              icon_indicator:set_width(pos.width)
            end,
          }

          local icon = wibox.widget {
            widget = wibox.container.margin,
            margins = theme_vars.item_paddings,
            {
              widget = wibox.widget.imagebox,
              image = icon_theme:get_client_icon_path(c),
              resize = true,
            },
          }

          local stack = wibox.widget {
            layout = wibox.layout.stack,
            self.icon_container,
            icon,
            icon_indicator,
          }
          self:set_widget(stack)
          update_client_look(self, c)
        end,
        update_callback = update_client_look,
      },
    },
  }
end

local function systray()
  local button = widgets.button.text.state {
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.wibar.item_bg,
    on_normal_bg = beautiful.wibar.item_bg,
    normal_fg = beautiful.colors.grey,
    on_normal_fg = beautiful.colors.green,
    paddings = dpi(3),
    forced_height = USABLE_WIBAR_HEIGHT,
    forced_width = USABLE_WIBAR_HEIGHT,
    halign = "center",
    font = beautiful.icons.chevron_up.font,
    on_text = beautiful.icons.chevron_down.icon,
    text = beautiful.icons.chevron_up.icon,
    on_by_default = false,
    on_turn_on = function()
      systray_popup:show()
    end,
    on_turn_off = function()
      systray_popup:hide()
    end,
  }

  -- Automatically close the systray.
  systray_popup:connect_signal("visibility", function(_, state)
    if state == true then
      button:turn_on()
    else
      button:turn_off()
    end
  end)

  return button
end

local function textclock()
  return widgets.button.basic.normal {
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.wibar.item_bg,
    paddings = dpi(6),
    forced_height = USABLE_WIBAR_HEIGHT,
    child = wibox.widget {
      widget = wibox.widget.textclock,
      format = string.format(
        "%s%s%s",
        helpers.ui.generate_markup("%H", { color = beautiful.colors.white }),
        helpers.ui.generate_markup(":", { color = beautiful.accent, bold = true }),
        helpers.ui.generate_markup("%M", { color = beautiful.colors.white })
      ),
    },
    on_press = function()
      calendar_popup:toggle()
    end,
  }
end

local function status_icons()
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

  local battery_icon = widgets.text {
    color = beautiful.accent,
    font = beautiful.icons.battery_half.font,
    text = beautiful.icons.battery_half.icon,
    size = 12,
    forced_height = dpi(24),
    forced_width = dpi(24),
    halign = "center",
  }

  local volume_icon = widgets.text {
    color = beautiful.accent,
    font = beautiful.icons.volume_normal.font,
    text = beautiful.icons.volume_normal.icon,
    size = 12,
    forced_height = dpi(24),
    forced_width = dpi(24),
    halign = "center",
  }

  pulseaudio_daemon:connect_signal("sinks::default::updated", function(_, device)
    if device.mute or device.volume == 0 then
      volume_icon:set_text(beautiful.icons.volume_off.icon)
    elseif device.volume <= 33 then
      volume_icon:set_text(beautiful.icons.volume_low.icon)
    elseif device.volume <= 66 then
      volume_icon:set_text(beautiful.icons.volume_normal.icon)
    elseif device.volume > 66 then
      volume_icon:set_text(beautiful.icons.volume_high.icon)
    end
  end)

  local UPower_DeviceState = {
    Unknown = 0,
    Charging = 1,
    Discharging = 2,
    Empty = 3,
    Fully_charged = 4,
    Pending_charge = 5,
    Pending_discharge = 6,
  }

  upower_daemon:connect_signal("battery::update", function(_, device)
    if device.State == UPower_DeviceState.Fully_charged then
      battery_icon:set_text(beautiful.icons.battery_full.icon)
    elseif device.State == UPower_DeviceState.Charging then
      battery_icon:set_text(beautiful.icons.battery_bolt.icon)
    elseif device.percentage > 66 then
      battery_icon:set_text(beautiful.icons.battery_three_quarter)
    elseif device.percentage >= 33 then
      battery_icon:set_text(beautiful.icons.battery_half.icon)
    elseif device.percentage < 33 then
      battery_icon:set_text(beautiful.icons.battery_quarter.icon)
    end
  end)

  local wifi_icon = widgets.text {
    color = beautiful.accent,
    font = beautiful.icons.wifi_high.font,
    text = beautiful.icons.wifi_high.icon,
    size = 12,
    forced_height = dpi(24),
    forced_width = dpi(24),
    halign = "center",
  }

  network_daemon:connect_signal("wireless_state", function(_, state)
    if state == false then
      wifi_icon:set_text(beautiful.icons.wifi_off.icon)
    else
      wifi_icon:set_text(beautiful.icons.wifi_high.icon)
    end
  end)
  network_daemon:connect_signal("access_point::connected", function(_, _, strength)
    if strength < 33 then
      wifi_icon:set_text(beautiful.icons.wifi_low.icon)
    elseif strength >= 33 then
      wifi_icon:set_text(beautiful.icons.wifi_medium.icon)
    elseif strength >= 66 then
      wifi_icon:set_text(beautiful.icons.wifi_high.icon)
    end
  end)

  local layout = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(4),
    in_container(wifi_icon),
    in_container(battery_icon),
    in_container(volume_icon),
  }

  return widgets.button.basic.normal {
    forced_height = USABLE_WIBAR_HEIGHT,
    normal_bg = beautiful.wibar.item_bg,
    paddings = dpi(6),
    on_press = function()
      info_panel:toggle()
    end,
    child = layout,
  }
end

screen.connect_signal("request::desktop_decoration", function(s)
  s.wibar = awful.popup {
    screen = s,
    type = "dock",
    position = beautiful.wibar.position,
    minimum_width = s.geometry.width,
    maximum_width = s.geometry.width,
    maximum_height = beautiful.wibar.height,
    bg = beautiful.wibar.bg,
    height = beautiful.wibar.height,
    widget = wibox.widget {
      widget = wibox.container.margin,
      margins = beautiful.wibar.paddings,
      {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(6),
          layoutbox(s),
          taglist(s),
        },
        tasklist(s),
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(6),
          status_icons(),
          systray(s),
          textclock(),
        },
      },
    },
  }

  s.wibar:struts {
    top = beautiful.wibar.height,
  }
end)
