{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.fht.desktop.xorg.enable {
  fonts = {
    # Install different font packages.
    fonts = with pkgs; [
      noto-fonts-emoji
      twemoji-color-font
      # -*-
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      # -*-
      (nerdfonts.override {fonts = ["Iosevka"];})
      fht.roundy
    ];

    # Use fontconfig for font management.
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      # Setup default fonts to use on the system.
      defaultFonts = {
        emoji = ["Twitter Color Emoji" "Noto Color Emoji"];
        monospace = ["Roundy" "Iosevka Nerd Font"];
        sansSerif = ["Noto Sans" "Twemoji" "Noto Color Emoji"];
        serif = ["Noto" "Twitter Color Emoji" "Noto Color Emoji"];
      };
    };
  };
}
