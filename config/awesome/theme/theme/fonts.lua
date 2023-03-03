---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.fonts'
---------------------------------------------------------------------------------

return function(_)
  local fonts = {}

  -- Main font to use, exclude the size since it's gonna be used by different widgets
  -- (for example, the text widget), fonts.font will include the size though.
  fonts.font_name = "monospace"

  -- Main icon font to use, this should be for the different glyphs that get put around
  -- the configuration (wibar, notifications, etc.)
  fonts.icon_font_name = "Font Awesome 6 Pro Solid"

  -- Default font size, nothing special.
  fonts.font_size = 12

  ---Create working font definition string to use with AwesomeWM widgets
  ---@param name string
  ---@param size number
  function fonts.create_font(name, size)
    return string.format("%s %d", name, size)
  end

  -- Create fonts with given sizes
  fonts.font = fonts.create_font(fonts.font_name, fonts.font_size)
  fonts.icon_font = fonts.create_font(fonts.icon_font_name, fonts.font_size)

  return fonts
end
