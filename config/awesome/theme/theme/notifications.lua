---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.fonts'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local notifications = { notification = {} }

  notifications.notification.font = theme.font
  notifications.notification.bg = theme.colors.black .. theme.opacity_modifier
  notifications.notification.alt_bg = theme.colors.darker_black .. theme.opacity_modifier
  notifications.notification.fg_low = theme.colors.grey_fg2
  notifications.notification.fg_normal = theme.accent
  notifications.notification.fg_critical = theme.colors.red
  notifications.notification.paddings = dpi(8)
  notifications.notification.width = dpi(260)
  notifications.notification.height = dpi(540)
  notifications.notification.progressbar_bg_color = theme.colors.black2
  notifications.notification_spacing = dpi(8)

  return notifications
end
