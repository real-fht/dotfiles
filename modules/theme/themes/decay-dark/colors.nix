rec {
  # Color definitions that guide all my system configuration colors
  # From TTY to kitty to Neovim to the GTK theme

  # NOTE: Make sure to NOT include a '#' in the colors!

  # Background color variations
  black            = "101419"; # Main background color
  black2           = "13171c"; # Background color for surfaces and buttons
  darker_black     = "0e1217"; # Contrast background for static stuff
  onebg            = "14191f"; # Light contrast background for borders and separators
  oneb2            = "181e25"; # Rarely used, generally for contrast
  oneb3            = "1a1e23"; # Same purpose as ^

  # Foreground color variations
  white            = "b6beca"; # General foreground
  grey             = "41454a"; # Comments, misc stuff
  grey_fg          = "494d52"; # Hints, notices, separators
  grey_fg2         = "505459"; # Rarely used, generally for contrast
  light_grey       = "5a5e63"; # Same purpose as ^

  # General colors for various purposes
  blue             = "70a5eb";
  cyan             = "74bee9";
  green            = "78DBA9";
  magenta          = "c68aee";
  red              = "e05f65";
  statusline       = "1c2026";
  yellow           = "f1cf8a";

  # What should be the main and secondary color apart from basic  background and
  # foreground (like for example, focused item, etc...)
  accent           = blue;
  secondary_accent = cyan;
}
