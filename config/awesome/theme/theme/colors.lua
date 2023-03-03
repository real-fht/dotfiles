---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.colors'
---------------------------------------------------------------------------------

local hcolor = require "helpers.color"

return function(_)
  local colors = {}

  -- Main color definition, accessed through beautiful.colors.<name>
  -- These are automatically generated (and hopefully checked) by NixOS.
  colors.colors = dofile(os.getenv "XDG_CONFIG_HOME" .. "/theme/awesome/palette.lua")

  -- Aliases to colors.accent and colors.secondary_accent for compatibility reasons.
  -- Also generate darker variants for some very subtle nuance in the UI.
  colors.accent = colors.colors.accent
  colors.secondary_accent = colors.colors.secondary_accent
  colors.darker_accent = hcolor.darken(colors.accent)
  colors.darker_secodary_accent = hcolor.darken(colors.secondary_accent)

  -- Transparent color for some use cases (unhovered buttons, etc.)
  colors.colors.transparent = colors.colors.black .. "00"

  ---Opacity modifier calculator, where opacity is a number between 0 and 1
  --- let transpary_color = "#101419" .. beautiful.opacity(0.88)
  ---@param opacity number
  ---@return string
  function colors.opacity(opacity)
    local to_255 = math.floor(255 * opacity)
    return string.format("%02x", to_255)
  end

  -- General opacity used pretty much everywhere.
  colors.opacity_modifier = colors.opacity(0.95)

  return colors
end
