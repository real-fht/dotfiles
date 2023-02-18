---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'ui.popups.app-launcher'
---------------------------------------------------------------------------------

local apps = require("config.apps")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local bling = require("modules.bling")
local helpers = require("helpers")

-- stylua: ignore start
return bling.widget.app_launcher {
    -- Behaviour settings.
    -- -*- Icon theme settings
    -- -*- Widget Popup settings.
    background                    = beautiful.app_launcher_bg,
    favorites                     = {},
    hide_on_launcher              = true,
    hide_on_left_clicked_outside  = true,
    hide_on_right_clicked_outside = true,
    icon_size                     = 48,
    icon_theme                    = beautiful.icon_theme,
    placement                     = function(c)
        return awful.placement.left(c, {
            margins = { left = beautiful.useless_gap },
        })
    end,
    reset_on_hide                 = true,
    search_commands               = true,
    select_before_spawn           = true,
    show_on_focused_screen        = true,
    skip_commands                 = { 'picom' },
    skip_names                    = { 'Flameshot', 'lf', 'XColor' },
    sort_alphabetically           = true,
    terminal                      = apps.terminal,
    type                          = 'splash',
    -- -*- Widget prompt settings
    prompt_color                  = beautiful.app_launcher_prompt_bg,
    prompt_height                 = beautiful.app_launcher_prompt_height,
    prompt_icon                   = '',
    prompt_icon_markup            = '',
    prompt_margins                = 0,
    prompt_paddings               = beautiful.app_launcher_prompt_paddings,
    prompt_text                   = helpers.ui.generate_markup('Search: ', { color = beautiful.accent, bold = true }),
    prompt_text_color             = beautiful.app_launcher_prompt_fg,
    -- -*- App list container
    apps_per_column               = 1,
    apps_per_row                  = 7,
    expand_apps                   = false,
    apps_spacing                  = beautiful.app_launcher_apps_spacing,
    apps_margin                   = beautiful.app_launcher_apps_margin,
    -- -*- Per app theming
    app_content_layout            = 'horizontal',
    app_content_padding           = 0,
    app_content_spacing           = dpi(6),
    app_height                    = dpi(54),
    app_icon_halign               = 'left',
    app_icon_height               = dpi(48),
    app_icon_width                = dpi(48),
    app_name_font                 = beautiful.font_name,
    app_name_halign               = 'center',
    app_name_normal_color         = beautiful.app_launcher_app_normal_fg,
    app_name_selected_color       = beautiful.app_launcher_app_selected_fg,
    app_normal_color              = beautiful.app_launcher_app_normal_bg,
    app_normal_hover_color        = beautiful.app_launcher_app_normal_hover_bg,
    app_selected_color            = beautiful.app_launcher_app_selected_bg,
    app_shape                     = helpers.ui.rounded_rect(),
    app_show_icon                 = true,
    app_width                     = dpi(250),
}
-- stylua: ignore end
