---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.notifications.box'
-- Available theme variables:
-- notification_font
-- notification_bg
-- notification_alt_bg
-- notification_fg_low
-- notification_fg_normal
-- notification_fg_critical
-- notificatin_paddings
-- notification_width
-- notification_height
-- notification_progressbar_bg_color
---------------------------------------------------------------------------------

local animation = require("modules.animation")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gshape = require("gears.shape")
local helpers = require("helpers")
local icon_theme = require("modules.icon_theme")
local naughty = require("naughty")
local wibox = require("wibox")
local widgets = require("ui.widgets")

-- Default settings in case they're not set.
naughty.persistence_enabled = true

local function get_oldest_notification()
  for _, notification in ipairs(naughty.active) do
    if notification and notification.timeout > 0 then
      return notification
    end
  end
  -- Fallback to first one.
  return naughty.active[1]
end

naughty.connect_signal("added", function(n)
  if n.title == "" or n.title == nil then
    n.title = n.app_name
  end

  if n._private.app_font_icon == nil then
    n.app_font_icon = beautiful.get_font_icon_for_app_name(n.app_name)
    if n.app_font_icon == nil then
      n.app_font_icon = beautiful.window_icon
    end
  else
    n.app_font_icon = n._private.app_font_icon
  end
  n.font_icon = n._private.font_icon

  if type(n._private.app_icon) == "table" then
    n.app_icon = icon_theme:choose_icon(n._private.app_icon)
  else
    n.app_icon = icon_theme:get_icon_path(n._private.app_icon or n.app_name)
  end

  if type(n.icon) == "table" then
    n.icon = icon_theme:choose_icon(n.icon)
  end

  if n.app_icon == "" or n.app_icon == nil then
    n.app_icon = icon_theme:get_icon_path("application-default-icon")
  end

  if (n.icon == "" or n.icon == nil) and n.font_icon == nil then
    n.font_icon = beautiful.message_icon
    n.icon = icon_theme:get_icon_path("preferences-desktop-notification-bell")
  end
end)

naughty.connect_signal("request::action_icon", function(action, _, hints)
  -- Proper action icon handling, using gtk icon theme.
  action.icon = icon_theme:get_icon_path(hints.id)
end)

naughty.connect_signal("request::display", function(n)
  -- Use custom accent based on notification urgency.
  local urgency_color = beautiful["notification_fg_" .. n.urgency] or beautiful.notification_fg_normal

  local app_icon = nil
  if n.app_font_icon == nil then
    app_icon = wibox.widget({
      -- Don't allow app icon image to take all the space.
      widget = wibox.container.constraint,
      strategy = "max",
      height = dpi(24),
      width = dpi(24),
      {
        widget = wibox.widget.imagebox,
        halign = "center",
        valign = "center",
        clip_shape = helpers.ui.rounded_rect(beautiful.border_radius),
        image = n.app_icon,
      },
    })
  else
    -- Otherwise use font app icon.
    app_icon = widgets.text({
      size = 12,
      color = urgency_color,
      -- halign = 'center',
      -- valign = 'center',
      font = n.app_font_icon.font,
      text = n.app_font_icon.icon,
    })
  end

  local app_name = widgets.text({
    size = 12,
    halign = "left",
    valign = "center",
    text = n.app_name:gsub("^%l", string.upper),
  })

  local dismiss_button = widgets.button.text.normal({
    font = beautiful.icons.xmark.font,
    text = beautiful.icons.xmark.icon,
    normal_bg = beautiful.colors.transparent,
    normal_fg = beautiful.colors.grey_fg,
    halign = "center",
    valign = "center",
    forced_height = dpi(24),
    forced_width = dpi(24),
    size = 12,
    on_release = function()
      n:destroy(naughty.notification_closed_reason.dismissed_by_user)
    end,
  })

  local timeout_bar = wibox.widget({
    widget = wibox.widget.progressbar,
    color = urgency_color,
    background_color = beautiful.notification_progressbar_bg_color,
    value = 0,
    forced_height = dpi(2),
    forced_width = 1,
    max_value = 100,
  })

  local icon = nil
  if n.font_icon == nil then
    icon = wibox.widget({
      widget = wibox.container.constraint,
      strategy = "max",
      height = dpi(24),
      width = dpi(24),
      {
        widget = wibox.widget.imagebox,
        clip_shape = helpers.ui.rounded_rect(beautiful.corner_radius),
        image = n.icon,
      },
    })
  else
    icon = widgets.text({
      size = 24,
      color = urgency_color,
      font = n.font_icon.font,
      text = n.font_icon.icon,
    })
  end

  local title = wibox.widget({
    widget = wibox.container.scroll.horizontal,
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    speed = 50,
    widgets.text({
      size = 12,
      bold = true,
      text = n.title,
    }),
  })

  local message = widgets.text({
    size = 12,
    text = n.message,
  })

  local actions = wibox.widget({
    layout = wibox.layout.flex.horizontal,
    fill_space = true,
    spacing = dpi(15),
  })

  for _, action in ipairs(n.actions) do
    local button = widgets.button.text.normal({
      size = 12,
      paddings = beautiful.notification_paddings,
      normal_bg = beautiful.colors.transparent,
      normal_fg = beautiful.colors.white,
      text = action.name,
      halign = "center",
      valign = "center",
      on_press = function()
        action:invoke()
      end,
    })
    actions:add(button)
  end

  local n_box = naughty.layout.box({
    notification = n,
    border_width = 0,
    border_color = beautiful.accent,
    hide_on_right_click = false,
    maximum_width = beautiful.notification_width,
    shape = gshape.rectangle,
    maximum_height = beautiful.notification_height,
    offset = { y = dpi(10) }, -- spacing between notifications
    screen = awful.screen.focused(),
    -- How the notificatin should appear?
    widget_template = {
      layout = wibox.layout.fixed.vertical,
      spacing = 0,
      {
        widget = wibox.container.background,
        bg = beautiful.notification_alt_bg,
        {
          widget = wibox.container.margin,
          margins = beautiful.notification_paddings,
          {
            layout = wibox.layout.align.horizontal,
            spacing = dpi(8),
            {

              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(4),
              app_icon,
              app_name,
            },
            nil,
            dismiss_button,
          },
        },
      },
      timeout_bar,
      {
        widget = wibox.container.margin,
        margins = beautiful.notification_paddings,
        {
          layout = wibox.layout.fixed.vertical,
          {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(8),
            wibox.container.place(icon),
            {
              layout = wibox.layout.fixed.vertical,
              title,
              message,
            },
          },
          actions,
          -- {
          --     layout = wibox.layout.fixed.horizontal,
          --     helpers.ui.vertical_padding(dpi(8)),
          --     wibox.container.place(actions),
          -- },
        },
      },
    },
  })
  n_box.buttons = {}

  local anim = animation:new({
    duration = n.timeout,
    target = 100,
    easing = animation.easing.linear,
    reset_on_stop = false,
    update = function(self, pos)
      timeout_bar.value = pos
    end,
  })

  anim:connect_signal("ended", function()
    n:destroy()
  end)

  n_box:connect_signal("mouse::enter", function()
    -- Absurdly big number because setting it to 0 doesn't work
    n:set_timeout(4294967)
    anim:stop()
  end)

  n_box:connect_signal("mouse::leave", function()
    anim:start()
  end)

  local notification_height = n_box.height + beautiful.notification_spacing
  local total_notifications_height = #naughty.active * notification_height

  if total_notifications_height > n.screen.workarea.height then
    -- Always try to keep enough space for notifications.
    get_oldest_notification():destroy(naughty.notification_closed_reason.too_many_on_screen)
  end

  anim:start()
end)
