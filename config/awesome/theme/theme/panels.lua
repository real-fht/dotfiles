---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.theme.panels'
---------------------------------------------------------------------------------

local dpi = require("beautiful.xresources").apply_dpi

return function(theme)
  local panels = { panels = {} }

  -- Info panel.
  panels.panels.info = {}
  panels.panels.info.bg = theme.colors.black .. theme.opacity_modifier
  panels.panels.info.paddings = dpi(12)
  panels.panels.info.profile_image_size = dpi(70)
  panels.panels.info.button_width = dpi(90)
  panels.panels.info.button_height = dpi(60)
  panels.panels.info.button_bg = theme.colors.black2 .. theme.opacity_modifier

  return panels
end
