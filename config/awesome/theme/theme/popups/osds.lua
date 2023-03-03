---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.theme.osds'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local osds = { osds = {} }

  -- Volume osd settings.
  osds.osds.volume = {}
  osds.osds.volume.bg = theme.colors.black .. theme.opacity_modifier
  osds.osds.volume.slider_height = dpi(12)
  osds.osds.volume.slider_width = dpi(150)
  osds.osds.volume.slider_color = theme.accent
  osds.osds.volume.icon_fg = theme.accent
  osds.osds.volume.paddings = dpi(12)

  return osds
end
