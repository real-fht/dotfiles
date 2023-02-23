---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.wibar'
---------------------------------------------------------------------------------

local animation = require("modules.animation")
local awful = require("awful")
local beautiful = require("beautiful")
local gshape = require("gears.shape")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local icon_theme = require("modules.icon_theme")
local wibox = require("wibox")
local widgets = require("ui.widgets")
-- -*-
local calendar_popup = require("ui.popups.calendar")
local systray_popup = require("ui.popups.systray")

local USABLE_WIBAR_HEIGHT = (function()
  if type(beautiful.wibar_paddings) == "number" then
    return beautiful.wibar_height - (beautiful.wibar_paddings * 2)
  else
    return beautiful.wibar_height - beautiful.wibar_paddings.top - beautiful.wibar_paddings.bottom
  end
end)()

local function layoutbox(s)
  return widgets.button.basic.normal({
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.wibar_item_bg,
    press_bg = beautiful.wibar_item_bg,
    forced_height = USABLE_WIBAR_HEIGHT,
    forced_width = USABLE_WIBAR_HEIGHT,
    paddings = dpi(6),
    child = awful.widget.layoutbox({ screen = s }),
    on_press = function()
      require("ui.popups.layout-picker"):toggle()
    end,
  })
end

local function taglist(s)
  local function update_tag_look(self, tag)
    local targets = {}
    if tag.selected then
      targets.color = beautiful.taglist_item_color_focus
      targets.width = beautiful.taglist_item_width_focus
    elseif tag.urgent then
      targets.color = beautiful.taglist_item_color_urgent
      targets.width = beautiful.taglist_item_width_urgent
    elseif #tag:clients() > 0 then
      targets.color = beautiful.taglist_item_color_occupied
      targets.width = beautiful.taglist_item_width_occupied
    else
      targets.color = beautiful.taglist_item_color_normal
      targets.width = beautiful.taglist_item_width_normal
    end

    self.indicator_animation:set({
      color = helpers.color.hex_to_rgba(targets.color),
      width = targets.width,
    })
  end

  return widgets.container({
    bg = beautiful.wibar_item_bg,
    forced_height = USABLE_WIBAR_HEIGHT,
    paddings = dpi(6),
    child = awful.widget.taglist({
      screen = s,
      filter = awful.widget.taglist.filter.all,
      layout = { layout = wibox.layout.fixed.horizontal, spacing = beautiful.taglist_item_spacing },
      widget_template = {
        widget = wibox.container.background,
        forced_height = beautiful.taglist_item_height,
        create_callback = function(self, tag, _, _)
          local indicator = widgets.button.basic.normal({
            forced_height = beautiful.taglist_item_height,
            forced_width = beautiful.taglist_item_width_normal,
            normal_bg = beautiful.taglist_item_color_normal,
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
          })
          self.indicator_animation = animation:new({
            pos = {
              color = helpers.color.hex_to_rgba(beautiful.taglist_item_color_normal),
              width = beautiful.taglist_item_width_normal,
            },
            duration = 1 / 8,
            easing = animation.easing.linear,
            update = function(_, pos)
              indicator:set_bg(helpers.color.rgba_to_hex(pos.color))
              indicator:set_width(pos.width)
            end,
          })
          self:set_widget(indicator)
          update_tag_look(self, tag)
        end,
        update_callback = update_tag_look,
      },
    }),
  })
end

local function tasklist(s)
  local function update_client_look(self, c)
    local targets = {}

    if c.active then
      -- Indicator
      targets.width = beautiful.tasklist_indicator_width_focus
      targets.color = beautiful.tasklist_indicator_color_focus
      -- Container
      self.icon_container:turn_on()
    elseif c.urgent then
      -- Indicator
      targets.width = beautiful.tasklist_indicator_width_urgent
      targets.color = beautiful.tasklist_indicator_color_urgent
      self.icon_container:turn_on()
    elseif c.minimized then
      -- Indicator
      targets.width = beautiful.tasklist_indicator_width_minimized
      targets.color = beautiful.tasklist_indicator_color_minimized
      -- Container
      self.icon_container:turn_off()
    else
      -- The default.
      targets.width = beautiful.tasklist_indicator_width_normal
      targets.color = beautiful.tasklist_indicator_color_normal
      self.icon_container:turn_off()
    end

    self.icon_indicator_animation:set({
      width = targets.width,
      color = helpers.color.hex_to_rgba(targets.color),
    })
  end

  return widgets.container({
    bg = beautiful.colors.black, -- the items will have black2 bg
    forced_height = USABLE_WIBAR_HEIGHT,
    paddings = 0,
    child = awful.widget.tasklist({
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      layout = {
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.tasklist_item_spacing,
      },
      widget_template = {
        widget = wibox.container.background,
        forced_height = USABLE_WIBAR_HEIGHT,
        forced_width = USABLE_WIBAR_HEIGHT,
        halign = "center",
        valign = "center",
        create_callback = function(self, c, index, clients)
          self.icon_container = widgets.button.basic.state({
            normal_bg = beautiful.tasklist_item_bg_normal,
            on_normal_bg = beautiful.tasklist_item_bg_focus,
            on_by_default = c.focus,
            forced_height = USABLE_WIBAR_HEIGHT,
            forced_width = USABLE_WIBAR_HEIGHT,
          })

          local icon_indicator = widgets.container({
            shape = gshape.rounded_bar,
            forced_height = dpi(2),
            forced_width = beautiful.tasklist_indicator_width_normal,
            valign = "bottom",
            bg = beautiful.tasklist_indicator_color_normal,
          })

          self.icon_indicator_animation = animation:new({
            duration = 1 / 8,
            easing = animation.easing.linear,
            pos = {
              color = helpers.color.hex_to_rgba(beautiful.tasklist_indicator_color_normal),
              width = beautiful.tasklist_indicator_width_normal,
            },
            update = function(_, pos)
              icon_indicator:set_bg(helpers.color.rgba_to_hex(pos.color))
              icon_indicator:set_width(pos.width)
            end,
          })

          local icon = wibox.widget({
            widget = wibox.container.margin,
            margins = beautiful.tasklist_item_paddings,
            {
              widget = wibox.widget.imagebox,
              image = icon_theme:get_client_icon_path(c),
              resize = true,
            },
          })

          local stack = wibox.widget({
            layout = wibox.layout.stack,
            self.icon_container,
            icon,
            icon_indicator,
          })
          self:set_widget(stack)
          update_client_look(self, c)
        end,
        update_callback = update_client_look,
      },
    }),
  })
end

local function systray()
  local button = widgets.button.text.state({
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.wibar_item_bg,
    press_bg = beautiful.wibar_item_bg,
    normal_fg = beautiful.colors.grey,
    paddings = dpi(3),
    forced_height = USABLE_WIBAR_HEIGHT,
    forced_width = USABLE_WIBAR_HEIGHT,
    halign = "center",
    font = beautiful.icons.chevron_up.font,
    on_text = beautiful.icons.chevron_down.icon,
    text = beautiful.icons.chevron_up.icon,
    on_press = function()
      systray_popup:toggle()
    end,
  })

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
  return widgets.button.basic.normal({
    shape = helpers.ui.rounded_rect(),
    normal_bg = beautiful.wibar_item_bg,
    press_bg = beautiful.wibar_item_bg,
    paddings = dpi(6),
    forced_height = USABLE_WIBAR_HEIGHT,
    child = wibox.widget({
      widget = wibox.widget.textclock,
      format = string.format(
        "%s%s%s",
        helpers.ui.generate_markup("%H", { color = beautiful.colors.white }),
        helpers.ui.generate_markup(":", { color = beautiful.accent, bold = true }),
        helpers.ui.generate_markup("%M", { color = beautiful.colors.white })
      ),
    }),
    on_press = function()
      calendar_popup:toggle()
    end,
  })
end

screen.connect_signal("request::desktop_decoration", function(s)
  s.wibar = awful.wibar({
    screen = s,
    type = "dock",
    position = "bottom",
    minimum_width = s.geometry.width,
    maximum_width = s.geometry.width,
    maximum_height = beautiful.wibar_height,
    widget = wibox.widget({
      widget = wibox.container.margin,
      margins = beautiful.wibar_paddings,
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
          systray(s),
          textclock(),
        },
      },
    }),
  })
end)
