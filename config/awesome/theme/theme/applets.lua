---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.theme.applets'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local applets = { applets = {} }

  -- Wifi applet.
  applets.applets.wifi = {}
  applets.applets.wifi.bg = theme.colors.black .. theme.opacity_modifier
  applets.applets.wifi.paddings = dpi(12)
  applets.applets.wifi.item_spacing = dpi(6)
  applets.applets.wifi.item_paddings = dpi(6)

  return applets
end
