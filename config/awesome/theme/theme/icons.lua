---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@module 'theme.colors'
---------------------------------------------------------------------------------

return function(theme)
  local icons = {}
  -- List of icon definitions.
  local nerd_font_name = theme.font_name
  local font_awesome_6_solid_font_name = "Font Awesome 6 Pro Solid"
  local font_awesome_6_brands_font_name = "Font Awesome 6 Pro Brands"
  -- stylua: ignore start
  icons.icons                           = {
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

  -- HUH? why an "application list"
  -- Not only this helps with quickly getting the commands, but alson getting and
  -- associating font icons to different applications with ease
  -- (if it wasn't obvious, stolen from @Kasper24/KwesomeDE)
  icons.apps                            = {
      kitty                  = { command = 'kitty', class = 'kitty', icon = icons.icons.laptop_code },
      alacritty              = { command = 'alacritty', class = 'Alacritty', icon = icons.icons.laptop_code },
      termite                = { command = 'termite', class = 'Termite', icon = icons.icons.laptop_code },
      urxvt                  = { command = 'urxvt', class = 'URxvt', icon = icons.icons.laptop_code },
      st                     = { command = 'st', class = 'st', icon = icons.icons.laptop_code },
      st_256color            = { command = 'st-256color', class = 'st-256color', icon = icons.icons.laptop_code },
      htop                   = { command = 'kitty --class htop htop', class = 'htop', icon = icons.icons.system_monitor },
      nm_connection_editor   = {
          command = 'nm-connection-editor',
          class   = 'Nm-connection-editor',
          icon    = icons.icons.router,
      },
      network_manager_dmenu  = {
          name    = 'network',
          command = 'networkmanager_dmenu',
          class   = 'Rofi',
          icon    = icons.icons.router,
      },
      pavucontrol            = { command = 'pavucontrol', class = 'Pavucontrol', icon = icons.icons.speaker },
      blueman_manager        = {
          name    = 'bluetooth',
          command = 'blueman-manager',
          class   = 'Blueman-manager',
          icon    = icons.icons.bluetooth,
      },
      file_roller            = { command = 'file-roller', class = 'File-roller', icon = icons.icons.archeive },
      lxappearance           = { command = 'Lxappearance', class = 'lxappearance', icon = icons.icons.palette },
      nvidia_settings        = { command = 'nvidia-settings', class = 'Nvidia-settings', icon = icons.icons.nvidia },
      sxiv                   = { command = "sxiv", class = "Sxiv", icon = icons.icons.image },
      feh                    = { command = 'feh', class = 'feh', icon = icons.icons.image },
      flameshot_gui          = { command = 'flameshot gui -p ~/Pictures', class = 'flameshot', icon = icons.icons.camera_retro },
      flameshot              = { command = 'flameshot full -c -p ~/Pictures', class = 'flameshot', icon = icons.icons.camera_retro },
      screenshot_select      = {
          name = 'Screenshot tool',
          icon = icons.icons.camera_retro,
      },
      gnome_calculator       = { command = 'gnome-calculator', class = 'Gnome-calculator', icon = icons.icons.calculator },
      gnome_system_monitor   = {
          name    = 'system-monitor',
          command = 'gnome-system-monitor',
          class   = 'Gnome-system-monitor',
          icon    = icons.icons.system_monitor,
      },
      notepadqq              = { command = 'notepadqq', class = 'Notepadqq', icon = icons.icons.note },
      ranger                 = { command = 'kitty --class ranger ranger', class = 'ranger', icon = icons.icons.file_manager },
      nemo                   = { command = 'nemo', class = 'Nemo', icon = icons.icons.file_manager },
      thunar                 = { class = 'Thunar', icon = icons.icons.file_manager },
      files                  = { class = 'files', icon = icons.icons.file_manager },
      firefox                = { command = 'firefox', class = 'firefox', icon = icons.icons.firefox },
      vivaldi                = { command = 'vivaldi-stable', class = 'Vivaldi-stable', icon = icons.icons.chrome },
      chromium               = { class = 'Chromium', icon = icons.icons.chrome },
      emacs                  = { class = 'Emacs', icon = icons.icons.code },
      vim                    = { class = 'vim', icon = icons.icons.code },
      vscode                 = { command = 'code', class = 'Code', icon = icons.icons.code },
      android_studio         = { command = 'android-studio', class = 'jetbrains-studio', icon = icons.icons.code },
      qt_creator             = { command = 'qtcreator', class = 'QtCreator', icon = icons.icons.code },
      lazygit                = { command = 'kitty --class gitqlient lazygit', class = 'gitqlient', icon = icons.icons.git },
      gitkraken              = { command = 'gitkraken', class = 'GitKraken', icon = icons.icons.gitkraken },
      discord                = { command = 'discocss', class = 'discord', icon = icons.icons.discord },
      telegram               = { command = 'kotatogram-desktop', class = 'KotatogramDesktop', icon = icons.icons.telegram },
      kotatogram             = { command = 'telegram-desktop', class = 'TelegramDesktop', icon = icons.icons.telegram },
      spotify                = { command = 'spotify', class = 'Spotify', icon = icons.icons.spotify },
      ncmpcpp                = { command = 'kitty --class mopidy ncmpcpp', class = 'mopidy', icon = icons.icons.spotify },
      steam                  = { command = 'steam', class = 'Steam', icon = icons.icons.steam },
      lutris                 = { command = 'lutris', class = 'Lutris', icon = icons.icons.gamepad_alt },
      heroic                 = { command = 'heroic', class = 'heroic', icon = icons.icons.gamepad_alt },
      rockstar_games_launcer = { name = 'Rockstar Games Launcher', icon = icons.icons.gamepad_alt },
      rocket_league          = { class = 'steam_app_252950', icon = icons.icons.gamepad_alt },
      gta_v                  = { name = 'Grand Theft Auto V', icon = icons.icons.gamepad_alt },
      openrgb                = { command = 'openrgb', class = 'openrgb', icon = icons.icons.led },
      artemis                = { command = 'artemis', class = 'artemis.ui.exe', icon = icons.icons.led },
      qbittorrent            = { command = 'qbittorrent', class = 'qBittorrent', icon = icons.icons.download },
      webtorrent             = { class = 'WebTorrent', icon = icons.icons.video_download },
      virtualbox             = { command = 'virtualbox', class = 'VirtualBox Manager', icon = icons.icons.computer },
      qemui                  = { class = 'Qemu-system-x86_64', icon = icons.icons.computer },
      thunderbird            = { command = 'thunderbird', class = 'Thunderbird', icon = icons.icons.envelope },
      bitwarden              = { command = 'bitwarden', class = 'Bitwarden', icon = icons.icons.unlock },
      keepassxc              = { command = 'keepassxc', class = 'KeePassXC', icon = icons.icons.unlock },
      libreoffice_writer     = { command = 'libreoffice', class = 'libreoffice-writer', icon = icons.icons.word },
      libreoffice_impress    = { command = 'libreoffice', class = 'libreoffice-impress', icon = icons.icons.powerpoint },
      libreoffice_calc       = { command = 'libreoffice', class = 'libreoffice-calc', icon = icons.icons.excel },
      screenshot             = { command = '', class = 'Screenshot', icon = icons.icons.camera_retro },
      record                 = { command = '', class = 'Record', icon = icons.icons.video },
      theme                  = { command = '', class = 'Theme', icon = icons.icons.spraycan },
      xfce4_settings_manager = {
          command = 'xfce4-settings-manager',
          class   = 'Xfce4-settings-manager',
          icon    = icons.icons.gear,
      },
  }

  ---@param name string
  ---@return { icon: string, font: string }?
  function icons.get_font_icon_for_app_name(name)
    for key, value in pairs(theme.apps) do
      key           = key:lower()
      name          = name:lower()
      local _name   = (value.name or ''):lower()
      local class   = (value.class or ''):lower()
      local command = (value.command or ''):lower()

      if key:match(name) or _name:match(name) or class:match(name) or command:match(name) then
        return value.icon
      end
    end
  end

  -- stylua: ignore end

  return icons
end
