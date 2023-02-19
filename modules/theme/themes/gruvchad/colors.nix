rec {
  # Color definitions that guide all my system configuration colors
  # From TTY to kitty to Neovim to the GTK theme

  # NOTE: Make sure to NOT include a '#' in the colors!

  # Background color variations
  black = "0c0e0f"; # Main background color
  black2 = "121415"; # Background color for surfaces and buttons
  darker_black = "060809"; # Contrast background for static stuff
  onebg = "161819"; # Light contrast background for borders and separators
  oneb2 = "1f2122"; # Rarely used, generally for contrast
  oneb3 = "27292a"; # Same purpose as ^

  # Foreground color variations
  white = "edeff0"; # General foreground
  grey = "343637"; # Comments, misc stuff
  grey_fg = "3e4041"; # Hints, notices, separators
  grey_fg2 = "484a4b"; # Rarely used, generally for contrast
  light_grey = "505253"; # Same purpose as ^

  # General colors for various purposes
  blue = "6791C9";
  cyan = "67AFC1";
  green = "78B892";
  magenta = "c58cec";
  red = "DF5B61";
  statusline = "101213";
  yellow = "ecd28b";

  # What should be the main and secondary color apart from basic  background and
  # foreground (like for example, focused item, etc...)
  accent = green;
  secondary_accent = cyan;
}
