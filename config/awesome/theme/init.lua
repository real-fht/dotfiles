---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme'
---------------------------------------------------------------------------------

-- stylua: ignore start

local dpi                                   = require 'beautiful.xresources'.apply_dpi
local gfs                                   = require 'gears.filesystem'
local XDG_CONFIG_HOME                       = gfs.get_xdg_config_home()
local XDG_DATA_HOME                         = gfs.get_xdg_data_home()
local AWESOME_CONFIG_HOME                   = gfs.get_configuration_dir()

local theme                                 = {}
local opacity_modifier                      = 'ed'

-- Use colors that are also used across my system.
theme.colors                                = dofile(XDG_CONFIG_HOME .. '/theme/awesome/palette.lua')
theme.colors.transparent                    = theme.colors.black .. '00'

-- Font configuration.
theme.font_name                             = 'monospace' -- Use system's monospace.
theme.icon_font_name                        = 'Font Awesome 6 Pro Solid' -- PAID.
theme.font_size                             = 12
theme.font                                  = string.format('%s %d', theme.font_name, theme.font_size)
theme.icon_font                             = string.format('%s %d', theme.icon_font_name, theme.font_size)

-- Default fallback colors in case something isn't defined.
theme.bg_normal                             = theme.colors.black
theme.bg_focus                              = theme.colors.black
theme.bg_urgent                             = theme.colors.black2
theme.bg_minimize                           = theme.colors.onebg
theme.bg_systray                            = theme.colors.transparent
-- -*-
theme.fg_normal                             = theme.colors.grey_fg2
theme.fg_focus                              = theme.colors.white
theme.fg_urgent                             = theme.colors.red
theme.fg_minimize                           = theme.colors.light_grey

-- Accent color that defines the main color tone.
theme.accent                                = theme.colors.accent
theme.secondary_accent                      = theme.colors.secondary_accent

-- Default corner radius for UI elements.
theme.corner_radius                         = dpi(8) -- to match picom, 8px

-- Client decoration config (borders)
theme.useless_gap                           = dpi(8)
theme.border_width                          = 0
theme.border_color_normal                   = theme.colors.transparent
theme.border_color_active                   = theme.colors.oneb3
theme.border_color_marked                   = theme.colors.green

-- Client decoration config (titlebars)
theme.titlebar_size                         = dpi(36)
theme.titlebar_bg_focus                     = theme.colors.darker_black .. opacity_modifier
theme.titlebar_bg_normal                    = theme.colors.darker_black .. 'ee'
theme.titlebar_button_spacing               = dpi(4)
theme.titlebar_close_button_color_focus     = theme.colors.red
theme.titlebar_maximize_button_color_focus  = theme.colors.green
theme.titlebar_minimize_button_color_focus  = theme.colors.yellow
theme.titlebar_close_button_color_normal    = theme.colors.onebg
theme.titlebar_maximize_button_color_normal = theme.colors.onebg
theme.titlebar_minimize_button_color_normal = theme.colors.onebg
theme.titlebar_button_size                  = dpi(14)
theme.titlebar_paddings                     = { top = dpi(8), bottom = dpi(8), left = dpi(2), right = dpi(2) }

-- Notification settings.
theme.notification_font                     = theme.font
theme.notification_bg                       = theme.colors.black .. opacity_modifier
theme.notification_alt_bg                   = theme.colors.darker_black .. opacity_modifier
theme.notification_fg_low                   = theme.colors.grey_fg2
theme.notification_fg_normal                = theme.accent
theme.notification_fg_critical              = theme.colors.red
theme.notification_paddings                 = dpi(8)
theme.notification_width                    = dpi(260)
theme.notification_height                   = dpi(540)
theme.notification_progressbar_bg_color     = theme.colors.black2
theme.notification_spacing                  = dpi(8)

-- Layout picker settings.
theme.layout_picker_bg                      = theme.colors.black .. opacity_modifier
theme.layout_picker_alt_bg                  = theme.colors.darker_black .. opacity_modifier
theme.layout_picker_paddings                = dpi(8)
theme.layout_picker_button_spacing          = dpi(6)
theme.layout_picker_button_size             = dpi(30)
-- -*-  Layoutlist contained inside the layout picker.
theme.layoutlist_bg_normal                  = theme.colors.transparent
theme.layoutlist_bg_selected                = theme.colors.onebg .. opacity_modifier

-- Layout picker settings.
theme.systray_bg                            = theme.colors.black .. opacity_modifier
theme.systray_alt_bg                        = theme.colors.darker_black .. opacity_modifier
theme.systray_paddings                      = dpi(8)
theme.systray_icon_spacing                  = dpi(6)
theme.systray_icon_size                     = dpi(24)

-- Wibar settings.
theme.wibar_bg                              = theme.bg_normal .. opacity_modifier
theme.wibar_item_bg                         = theme.colors.transparent
theme.wibar_height                          = dpi(42)
theme.wibar_paddings                        = dpi(6)

-- Taglist settings.
theme.taglist_item_spacing                  = dpi(6)
theme.taglist_item_height                   = dpi(8)
theme.taglist_item_width_focus              = dpi(30)
theme.taglist_item_width_normal             = dpi(8)
theme.taglist_item_width_occupied           = dpi(12)
theme.taglist_item_width_urgent             = dpi(24)
-- -*-
theme.taglist_item_color_focus              = theme.accent
theme.taglist_item_color_normal             = theme.colors.oneb2
theme.taglist_item_color_occupied           = theme.accent
theme.taglist_item_color_urgent             = theme.colors.red

-- Tasklist settings.
theme.tasklist_item_spacing                 = dpi(6)
theme.tasklist_item_paddings                = dpi(3) -- inner paddings
-- -*-
theme.tasklist_item_bg_focus                = theme.colors.oneb2
theme.tasklist_item_bg_normal               = theme.colors.black2
theme.tasklist_item_bg_urgent               = theme.colors.red .. '1c'
theme.tasklist_item_bg_minimized            = theme.wibar_bg -- theme.colors.black

-- Tag preview settings.
theme.tag_preview_client_bg                 = theme.colors.black2
theme.tag_preview_client_border_color       = theme.colors.transparent
theme.tag_preview_client_border_radius      = theme.corner_radius
theme.tag_preview_client_border_width       = theme.border_width
theme.tag_preview_client_opacity            = 0.5
theme.tag_preview_widget_bg                 = theme.colors.darker_black
theme.tag_preview_widget_border_color       = theme.colors.transparent
theme.tag_preview_widget_border_radius      = 0
theme.tag_preview_widget_border_width       = 0
theme.tag_preview_widget_margin             = dpi(4)

-- App launcher settings.
-- -*- General settings.
theme.app_launcher_bg                       = theme.colors.black
-- -*- Prompt settings.
theme.app_launcher_prompt_bg                = theme.colors.darker_black
theme.app_launcher_prompt_fg                = theme.colors.white
theme.app_launcher_prompt_height            = dpi(42)
theme.app_launcher_prompt_paddings          = dpi(8)
-- -*- App item setting.
-- theme.app_launcher_app_content_padding = dpi(6)
-- theme.app_launcher_app_content_spacing = dpi(6)
theme.app_launcher_apps_spacing             = dpi(6)
theme.app_launcher_app_normal_bg            = theme.app_launcher_bg
theme.app_launcher_app_normal_fg            = theme.colors.grey_fg2
theme.app_launcher_app_selected_bg          = theme.colors.onebg
theme.app_launcher_app_selected_fg          = theme.colors.white
theme.app_launcher_app_normal_hover_bg      = theme.colors.black2
-- -*- App list container.
theme.app_launcher_apps_margin              = dpi(6)

-- Calendar popup settings.
theme.calendar_bg                           = theme.colors.black .. opacity_modifier
theme.calendar_alt_bg                       = theme.colors.darker_black .. opacity_modifier
theme.calendar_paddings                     = dpi(12)

-- Power screen settings.
theme.power_screen_bg                       = theme.colors.black .. 'aa'
theme.power_screen_button_bg                = theme.colors.darker_black .. '2c'
theme.power_screen_button_size              = dpi(48)
theme.power_screen_button_spacing           = dpi(6)

-- Window swallowing settings.
theme.parent_filter_list                    = { "qutebrowser", "Gimp" }
theme.child_filter_list                     = {}
theme.swallowing_filter                     = true

-- Menu settings.
theme.menu_bg                               = theme.colors.black .. opacity_modifier
theme.menu_paddings                         = dpi(4)
theme.menu_button_spacing                   = dpi(2)
theme.menu_button_hover_bg                  = theme.colors.onebg .. opacity_modifier
theme.menu_button_press_bg                  = theme.colors.onebg .. opacity_modifier
theme.menu_button_height                    = dpi(30)
theme.menu_button_paddings                  = dpi(4)
theme.menu_button_submenu_caret_color       = theme.colors.grey

-- List of icon definitions.
local nerd_font_name                        = theme.font_name
local font_awesome_6_solid_font_name        = 'Font Awesome 6 Pro Solid'
local font_awesome_6_brands_font_name       = 'Font Awesome 6 Pro Brands'
theme.icons                                 = {
    ['repeat']                = { icon = '', font = font_awesome_6_solid_font_name },
    airplane                  = { icon = '', font = font_awesome_6_solid_font_name },
    airplane_off              = { icon = '', font = font_awesome_6_solid_font_name },
    amazon                    = { icon = '', font = font_awesome_6_brands_font_name },
    arch                      = { icon = '', font = nerd_font_name },
    archeive                  = { icon = '︁', font = font_awesome_6_solid_font_name },
    arrow_rotate_right        = { icon = '', font = font_awesome_6_solid_font_name },
    backward                  = { icon = '', font = font_awesome_6_solid_font_name },
    bars                      = { icon = '︁', font = font_awesome_6_solid_font_name },
    bars_staggered            = { icon = '', font = font_awesome_6_solid_font_name },
    battery_bolt              = { icon = '', font = font_awesome_6_solid_font_name },
    battery_full              = { icon = '', font = font_awesome_6_solid_font_name },
    battery_half              = { icon = '', font = font_awesome_6_solid_font_name },
    battery_quarter           = { icon = '', font = font_awesome_6_solid_font_name },
    battery_three_quarter     = { icon = '', font = font_awesome_6_solid_font_name },
    bell                      = { icon = '', font = font_awesome_6_solid_font_name },
    bluelight                 = { icon = '', font = font_awesome_6_solid_font_name },
    bluelight_off             = { icon = '', font = font_awesome_6_solid_font_name },
    bluetooth                 = { icon = '', font = nerd_font_name },
    bluetooth_off             = { icon = '', font = nerd_font_name },
    boombox                   = { icon = '', font = font_awesome_6_solid_font_name },
    box                       = { icon = '', font = font_awesome_6_solid_font_name },
    brightness                = { icon = '', font = font_awesome_6_solid_font_name },
    burn                      = { icon = '', font = font_awesome_6_solid_font_name },
    calculator                = { icon = '🖩︁', font = font_awesome_6_solid_font_name },
    calendar                  = { icon = '', font = font_awesome_6_solid_font_name },
    camera_retro              = { icon = '', font = font_awesome_6_solid_font_name },
    car_battery               = { icon = '', font = font_awesome_6_solid_font_name },
    caret_left                = { icon = '', font = font_awesome_6_solid_font_name },
    caret_right               = { icon = '', font = font_awesome_6_solid_font_name },
    chart_line                = { icon = '', font = font_awesome_6_solid_font_name },
    check                     = { icon = '', font = font_awesome_6_solid_font_name },
    chevron_circle_left       = { icon = '︁', font = font_awesome_6_solid_font_name },
    chevron_circle_right      = { icon = '︁', font = font_awesome_6_solid_font_name },
    chevron_down              = { icon = '', font = font_awesome_6_solid_font_name },
    chevron_right             = { icon = '', font = font_awesome_6_solid_font_name },
    chevron_up                = { icon = '', font = font_awesome_6_solid_font_name },
    chrome                    = { icon = '', font = font_awesome_6_brands_font_name },
    circle                    = { icon = '', font = font_awesome_6_solid_font_name },
    circle_check              = { icon = '', font = font_awesome_6_solid_font_name },
    circle_exclamation        = { icon = '︁', font = font_awesome_6_solid_font_name },
    circle_minus              = { icon = '', font = font_awesome_6_solid_font_name },
    circle_plus               = { icon = '', font = font_awesome_6_solid_font_name },
    clipboard                 = { icon = '', font = font_awesome_6_solid_font_name },
    clock                     = { icon = '', font = font_awesome_6_solid_font_name },
    cloud                     = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_bolt_moon           = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_bolt_sun            = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_fog                 = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_moon                = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_moon_rain           = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_sun                 = { icon = '', font = font_awesome_6_solid_font_name },
    cloud_sun_rain            = { icon = '', font = font_awesome_6_solid_font_name },
    clouds                    = { icon = '', font = font_awesome_6_solid_font_name },
    code                      = { icon = '', font = font_awesome_6_solid_font_name, size = 25 },
    code_branch               = { icon = '', font = font_awesome_6_solid_font_name },
    code_pull_request         = { icon = '︁', font = font_awesome_6_solid_font_name },
    command                   = { icon = '', font = font_awesome_6_solid_font_name },
    commit                    = { icon = '', font = font_awesome_6_solid_font_name },
    computer                  = { icon = '︁', font = font_awesome_6_solid_font_name },
    corona_cases              = { icon = '', font = font_awesome_6_solid_font_name },
    disc_drive                = { icon = '', font = font_awesome_6_solid_font_name },
    discord                   = { icon = '︁', font = font_awesome_6_brands_font_name },
    download                  = { icon = '︁', font = font_awesome_6_solid_font_name },
    envelope                  = { icon = '', font = font_awesome_6_solid_font_name },
    excel                     = { icon = '︁', font = font_awesome_6_solid_font_name },
    exit                      = { icon = '', font = font_awesome_6_solid_font_name },
    file                      = { icon = '', font = font_awesome_6_solid_font_name },
    file_manager              = { icon = '', font = font_awesome_6_solid_font_name },
    firefox                   = { icon = '︁', font = font_awesome_6_brands_font_name },
    flameshot                 = { icon = '', font = font_awesome_6_solid_font_name },
    folder_open               = { icon = '', font = font_awesome_6_solid_font_name },
    forward                   = { icon = '', font = font_awesome_6_solid_font_name },
    gamepad_alt               = { icon = '', font = font_awesome_6_solid_font_name, size = 20 },
    gear                      = { icon = '', font = font_awesome_6_solid_font_name },
    git                       = { icon = '', font = font_awesome_6_brands_font_name },
    github                    = { icon = '', font = font_awesome_6_brands_font_name },
    gitkraken                 = { icon = '︁', font = font_awesome_6_brands_font_name },
    gitlab                    = { icon = '', font = font_awesome_6_brands_font_name },
    grid                      = { icon = '︁', font = font_awesome_6_solid_font_name },
    hammer                    = { icon = '', font = font_awesome_6_solid_font_name },
    home                      = { icon = '', font = font_awesome_6_solid_font_name },
    image                     = { icon = '︁', font = font_awesome_6_solid_font_name },
    industry                  = { icon = '', font = font_awesome_6_solid_font_name },
    keyboard                  = { icon = '', font = font_awesome_6_solid_font_name },
    laptop_code               = { icon = '', font = font_awesome_6_solid_font_name },
    launcher                  = { icon = '', font = font_awesome_6_solid_font_name },
    led                       = { icon = '', font = font_awesome_6_brands_font_name, size = 30 },
    left                      = { icon = '', font = font_awesome_6_solid_font_name },
    lightbulb                 = { icon = '', font = font_awesome_6_solid_font_name },
    lightbulb_off             = { icon = '', font = font_awesome_6_solid_font_name },
    list                      = { icon = '︁', font = font_awesome_6_solid_font_name },
    list_music                = { icon = '', font = font_awesome_6_solid_font_name },
    location_dot              = { icon = '', font = font_awesome_6_solid_font_name },
    lock                      = { icon = '', font = font_awesome_6_solid_font_name },
    memory                    = { icon = '', font = font_awesome_6_solid_font_name },
    message                   = { icon = '︁', font = font_awesome_6_solid_font_name },
    microchip                 = { icon = '', font = font_awesome_6_solid_font_name },
    microphone                = { icon = '', font = font_awesome_6_solid_font_name },
    microphone_off            = { icon = '', font = font_awesome_6_solid_font_name },
    moon                      = { icon = '', font = font_awesome_6_solid_font_name },
    moon_cloud                = { icon = '', font = font_awesome_6_solid_font_name },
    mug_saucer                = { icon = '', font = font_awesome_6_solid_font_name },
    note                      = { icon = '︁', font = font_awesome_6_solid_font_name },
    nvidia                    = { icon = '︁', font = font_awesome_6_solid_font_name },
    paint                     = { icon = '︁', font = font_awesome_6_solid_font_name },
    palette                   = { icon = '🎨︁', font = font_awesome_6_solid_font_name },
    pause                     = { icon = '', font = font_awesome_6_solid_font_name },
    pen_to_square             = { icon = '︁', font = font_awesome_6_solid_font_name },
    play                      = { icon = '', font = font_awesome_6_solid_font_name },
    poweroff                  = { icon = '', font = font_awesome_6_solid_font_name },
    powerpoint                = { icon = '︁', font = font_awesome_6_solid_font_name },
    raindrops                 = { icon = '', font = font_awesome_6_solid_font_name },
    reboot                    = { icon = '', font = font_awesome_6_solid_font_name },
    reddit                    = { icon = '', font = font_awesome_6_brands_font_name },
    right_long                = { icon = '︁', font = font_awesome_6_solid_font_name },
    router                    = { icon = '︁', font = font_awesome_6_solid_font_name },
    scissors                  = { icon = '', font = font_awesome_6_solid_font_name },
    server                    = { icon = '', font = font_awesome_6_solid_font_name },
    shuffle                   = { icon = '', font = font_awesome_6_solid_font_name },
    signal_stream             = { icon = '', font = font_awesome_6_solid_font_name },
    skull                     = { icon = '', font = font_awesome_6_solid_font_name },
    snowflake                 = { icon = '', font = font_awesome_6_solid_font_name },
    speaker                   = { icon = '︁', font = font_awesome_6_solid_font_name },
    spotify                   = { icon = '', font = font_awesome_6_brands_font_name },
    spraycan                  = { icon = '', font = font_awesome_6_solid_font_name },
    square                    = { icon = '', font = font_awesome_6_solid_font_name },
    star                      = { icon = '︁', font = font_awesome_6_solid_font_name },
    steam                     = { icon = '︁', font = font_awesome_6_brands_font_name },
    sun                       = { icon = '', font = font_awesome_6_solid_font_name },
    sun_cloud                 = { icon = '', font = font_awesome_6_solid_font_name },
    suspend                   = { icon = '', font = font_awesome_6_solid_font_name },
    system_monitor            = { icon = '︁', font = font_awesome_6_solid_font_name },
    table_layout              = { icon = '', font = font_awesome_6_solid_font_name },
    tag                       = { icon = '', font = font_awesome_6_solid_font_name },
    telegram                  = { icon = '︁', font = font_awesome_6_brands_font_name },
    terminal                  = { icon = '', font = font_awesome_6_solid_font_name },
    thermometer_full          = { icon = '︁', font = font_awesome_6_solid_font_name, size = 30 },
    thermometer_half          = { icon = '', font = font_awesome_6_solid_font_name, size = 30 },
    thermometer_quarter       = { icon = '︁', font = font_awesome_6_solid_font_name, size = 30 },
    thermometer_three_quarter = { icon = '︁', font = font_awesome_6_solid_font_name, size = 30 },
    toggle_off                = { icon = '', font = font_awesome_6_solid_font_name },
    toggle_on                 = { icon = '', font = font_awesome_6_solid_font_name },
    trash                     = { icon = '', font = font_awesome_6_solid_font_name },
    triangle                  = { icon = '', font = font_awesome_6_solid_font_name },
    unlock                    = { icon = '︁', font = font_awesome_6_solid_font_name },
    usb                       = { icon = '', font = font_awesome_6_brands_font_name },
    usb_drive                 = { icon = '', font = font_awesome_6_solid_font_name },
    user                      = { icon = '', font = font_awesome_6_solid_font_name },
    video                     = { icon = '', font = font_awesome_6_solid_font_name },
    video_download            = { icon = '︁', font = font_awesome_6_solid_font_name },
    volume_high               = { icon = '', font = font_awesome_6_solid_font_name },
    volume_low                = { icon = '', font = font_awesome_6_solid_font_name },
    volume_normal             = { icon = '', font = font_awesome_6_solid_font_name },
    volume_off                = { icon = '', font = font_awesome_6_solid_font_name },
    wifi_high                 = { icon = '', font = font_awesome_6_solid_font_name },
    wifi_low                  = { icon = '', font = font_awesome_6_solid_font_name },
    wifi_medium               = { icon = '', font = font_awesome_6_solid_font_name },
    wifi_off                  = { icon = '', font = font_awesome_6_solid_font_name },
    window                    = { icon = '', font = font_awesome_6_solid_font_name },
    wired                     = { icon = '', font = font_awesome_6_solid_font_name },
    wired_off                 = { icon = '', font = font_awesome_6_solid_font_name },
    word                      = { icon = '︁', font = font_awesome_6_solid_font_name },
    wrench                    = { icon = '', font = font_awesome_6_solid_font_name },
    xmark                     = { icon = '', font = font_awesome_6_solid_font_name },
    xmark_fw                  = { icon = '', font = font_awesome_6_solid_font_name },
    youtube                   = { icon = '', font = font_awesome_6_brands_font_name },
}
theme.apps                                  = {
    kitty = { command = 'kitty', class = 'kitty', icon = theme.icons.laptop_code },
    alacritty = { command = 'alacritty', class = 'Alacritty', icon = theme.icons.laptop_code },
    termite = { command = 'termite', class = 'Termite', icon = theme.icons.laptop_code },
    urxvt = { command = 'urxvt', class = 'URxvt', icon = theme.icons.laptop_code },
    st = { command = 'st', class = 'st', icon = theme.icons.laptop_code },
    st_256color = { command = 'st-256color', class = 'st-256color', icon = theme.icons.laptop_code },
    htop = { command = 'kitty --class htop htop', class = 'htop', icon = theme.icons.system_monitor },
    nm_connection_editor = {
        command = 'nm-connection-editor',
        class = 'Nm-connection-editor',
        icon = theme.icons.router,
    },
    network_manager_dmenu = {
        name = 'network',
        command = 'networkmanager_dmenu',
        class = 'Rofi',
        icon = theme.icons.router,
    },
    pavucontrol = { command = 'pavucontrol', class = 'Pavucontrol', icon = theme.icons.speaker },
    blueman_manager = {
        name = 'bluetooth',
        command = 'blueman-manager',
        class = 'Blueman-manager',
        icon = theme.icons.bluetooth,
    },
    file_roller = { command = 'file-roller', class = 'File-roller', icon = theme.icons.archeive },
    lxappearance = { command = 'Lxappearance', class = 'lxappearance', icon = theme.icons.palette },
    nvidia_settings = { command = 'nvidia-settings', class = 'Nvidia-settings', icon = theme.icons.nvidia },
    wpgtk = { command = 'wpg', class = 'Wpg', icon = theme.icons.spraycan },
    feh = { command = 'feh', class = 'feh', icon = theme.icons.image },
    eye_of_gnome = { command = 'eog', class = 'Eog', icon = theme.icons.image },
    gwenview = { command = 'gwenview', class = 'gwenview', icon = theme.icons.image },
    flameshot_gui = { command = 'flameshot gui -p ~/Pictures', class = 'flameshot', icon = theme.icons.camera_retro },
    flameshot = { command = 'flameshot full -c -p ~/Pictures', class = 'flameshot', icon = theme.icons.camera_retro },
    screenshot_select = {
        name = 'Screenshot tool',
        icon = theme.icons.camera_retro,
    },
    gnome_calculator = { command = 'gnome-calculator', class = 'Gnome-calculator', icon = theme.icons.calculator },
    gnome_system_monitor = {
        name = 'system-monitor',
        command = 'gnome-system-monitor',
        class = 'Gnome-system-monitor',
        icon = theme.icons.system_monitor,
    },
    notepadqq = { command = 'notepadqq', class = 'Notepadqq', icon = theme.icons.note },
    ranger = { command = 'kitty --class ranger ranger', class = 'ranger', icon = theme.icons.file_manager },
    nemo = { command = 'nemo', class = 'Nemo', icon = theme.icons.file_manager },
    thunar = { class = 'Thunar', icon = theme.icons.file_manager },
    files = { class = 'files', icon = theme.icons.file_manager },
    firefox = { command = 'firefox', class = 'firefox', icon = theme.icons.firefox },
    vivaldi = { command = 'vivaldi-stable', class = 'Vivaldi-stable', icon = theme.icons.chrome },
    chromium = { class = 'Chromium', icon = theme.icons.chrome },
    emacs = { class = 'Emacs', icon = theme.icons.code },
    vim = { class = 'vim', icon = theme.icons.code },
    vscode = { command = 'code', class = 'Code', icon = theme.icons.code },
    android_studio = { command = 'android-studio', class = 'jetbrains-studio', icon = theme.icons.code },
    qt_creator = { command = 'qtcreator', class = 'QtCreator', icon = theme.icons.code },
    lazygit = { command = 'kitty --class gitqlient lazygit', class = 'gitqlient', icon = theme.icons.git },
    gitkraken = { command = 'gitkraken', class = 'GitKraken', icon = theme.icons.gitkraken },
    discord = { command = 'discocss', class = 'discord', icon = theme.icons.discord },
    telegram = { command = 'kotatogram-desktop', class = 'KotatogramDesktop', icon = theme.icons.telegram },
    kotatogram = { command = 'telegram-desktop', class = 'TelegramDesktop', icon = theme.icons.telegram },
    spotify = { command = 'spotify', class = 'Spotify', icon = theme.icons.spotify },
    ncmpcpp = { command = 'kitty --class mopidy ncmpcpp', class = 'mopidy', icon = theme.icons.spotify },
    steam = { command = 'steam', class = 'Steam', icon = theme.icons.steam },
    lutris = { command = 'lutris', class = 'Lutris', icon = theme.icons.gamepad_alt },
    heroic = { command = 'heroic', class = 'heroic', icon = theme.icons.gamepad_alt },
    rockstar_games_launcer = { name = 'Rockstar Games Launcher', icon = theme.icons.gamepad_alt },
    rocket_league = { class = 'steam_app_252950', icon = theme.icons.gamepad_alt },
    gta_v = { name = 'Grand Theft Auto V', icon = theme.icons.gamepad_alt },
    openrgb = { command = 'openrgb', class = 'openrgb', icon = theme.icons.led },
    artemis = { command = 'artemis', class = 'artemis.ui.exe', icon = theme.icons.led },
    qbittorrent = { command = 'qbittorrent', class = 'qBittorrent', icon = theme.icons.download },
    webtorrent = { class = 'WebTorrent', icon = theme.icons.video_download },
    virtualbox = { command = 'virtualbox', class = 'VirtualBox Manager', icon = theme.icons.computer },
    qemui = { class = 'Qemu-system-x86_64', icon = theme.icons.computer },
    thunderbird = { command = 'thunderbird', class = 'Thunderbird', icon = theme.icons.envelope },
    bitwarden = { command = 'bitwarden', class = 'Bitwarden', icon = theme.icons.unlock },
    keepassxc = { command = 'keepassxc', class = 'KeePassXC', icon = theme.icons.unlock },
    libreoffice_writer = { command = 'libreoffice', class = 'libreoffice-writer', icon = theme.icons.word },
    libreoffice_impress = { command = 'libreoffice', class = 'libreoffice-impress', icon = theme.icons.powerpoint },
    libreoffice_calc = { command = 'libreoffice', class = 'libreoffice-calc', icon = theme.icons.excel },
    screenshot = { command = '', class = 'Screenshot', icon = theme.icons.camera_retro },
    record = { command = '', class = 'Record', icon = theme.icons.video },
    theme = { command = '', class = 'Theme', icon = theme.icons.spraycan },
    xfce4_settings_manager = {
        command = 'xfce4-settings-manager',
        class = 'Xfce4-settings-manager',
        icon = theme.icons.gear,
    },
}

---@param name string
---@return { icon: string, font: string }?
function theme.get_font_icon_for_app_name(name)
  for key, value in pairs(theme.apps) do
    key = key:lower()
    name = name:lower()
    local _name = (value.name or ''):lower()
    local class = (value.class or ''):lower()
    local command = (value.command or ''):lower()

    if key:match(name) or _name:match(name) or class:match(name) or command:match(name) then
      return value.icon
    end
  end
end

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
