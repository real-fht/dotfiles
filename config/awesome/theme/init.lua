---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme'
---------------------------------------------------------------------------------

-- stylua: ignore start

local dpi                 = require 'beautiful.xresources'.apply_dpi
local gfs                 = require 'gears.filesystem'
local gtable              = require 'gears.table'
local hcolor              = require 'helpers.color'
local XDG_CONFIG_HOME     = gfs.get_xdg_config_home()
local XDG_DATA_HOME       = gfs.get_xdg_data_home()
local AWESOME_CONFIG_HOME = gfs.get_configuration_dir()

local theme               = {}

local function extend_theme_variables(to_merge)
  -- Sometimes we gotta be able to get our theme when creating variables
  local to_merged = require(to_merge)(theme)
  -- This is just a pretty wrapper around gtable.crush
  gtable.crush(theme, to_merged or {}, true)
end

extend_theme_variables("theme.theme.colors")
extend_theme_variables("theme.theme.fonts")
extend_theme_variables("theme.theme.widget-defaults")
extend_theme_variables("theme.theme.client-decorations")
extend_theme_variables("theme.theme.notifications")
extend_theme_variables("theme.theme.icons")
extend_theme_variables("theme.theme.popups")
extend_theme_variables("theme.theme.popups.osds")
extend_theme_variables("theme.theme.wibar")
extend_theme_variables("theme.theme.panels")
extend_theme_variables("theme.theme.applets")

local opacity_modifier            = theme.opacity_modifier

-- Default corner radius for UI elements.
theme.corner_radius               = dpi(8) -- to match picom, 8px

-- Power screen settings.
theme.power_screen_bg             = theme.colors.black .. 'aa'
theme.power_screen_button_bg      = theme.colors.darker_black .. '2c'
theme.power_screen_button_size    = dpi(48)
theme.power_screen_button_spacing = dpi(6)

-- Window swallowing settings.
theme.parent_filter_list          = { "qutebrowser", "Gimp" }
theme.child_filter_list           = {}
theme.swallowing_filter           = true


-- Audio applet settings.
theme.audio_applet_bg                             = theme.colors.black .. opacity_modifier
theme.audio_applet_alt_bg                         = theme.colors.darker_black .. opacity_modifier
theme.audio_applet_button_bg                      = theme.colors.onebg .. opacity_modifier
theme.audio_applet_paddings                       = dpi(12)
theme.audio_applet_item_spacing                   = dpi(6)
-- -*-
theme.audio_applet_icon_color                     = theme.audio_applet_accent
theme.audio_applet_icon_color_mute                = theme.colors.red
theme.audio_applet_default_checkbox_color         = theme.colors.light_grey
theme.audio_applet_default_checkbox_color_checked = theme.colors.green
-- -*-
theme.audio_applet_volume_slider_height           = dpi(12)
theme.audio_applet_volume_slider_bg_color         = theme.colors.onebg .. opacity_modifier
theme.audio_applet_volume_slider_color            = theme.audio_applet_accent
theme.audio_applet_volume_slider_color_mute       = theme.colors.red

for _, layout in pairs {
    'cornerne',
    'cornernw',
    'cornerse',
    'cornersw',
    'dwindle',
    'fairh',
    'fairv',
    'floating',
    'fullscreen',
    'magnifier',
    'max',
    'spiral',
    'tile',
    'tilebottom',
    'tileleft',
    'tiletop',
} do
  -- Custom layout icons, using the system's colors too.
  theme['layout_' .. layout] = XDG_CONFIG_HOME .. '/theme/awesome/layout-icons/layout-' .. layout .. '.svg'
end

-- Wallpaper, matches my system too.
theme.wallpaper = XDG_DATA_HOME .. '/wallpaper'

-- My profile icon/picture.
theme.profile_icon = AWESOME_CONFIG_HOME .. '/theme/profile.png'

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Papirus-Dark'

return theme

-- stylua: ignore end
