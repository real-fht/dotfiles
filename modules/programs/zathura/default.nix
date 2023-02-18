{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.programs.zathura = with types; {
    enable = mkBoolOpt' false "Whether to enable the Zathura PDF reader.";
  };

  config = let
    cfg = config.fht.programs.zathura;
  in
    mkIf cfg.enable {
      home.programs.zathura = {
        enable = true;
        options = {
          abort-clear-search = true;
          font = "monospace normal 12"; # Like every other program here.
          incremental-search = true; # Like vim's `:set incsearch`
          page-padding = 12; # Padding around pdf documents
          render-loading = true; # Better performance if i'm not mistaken
          statusbar-home-tilde = true; # Use a ~ instead of the /home/$USER
          statusbar-page-percent = true; # Show where I am inside a document
          statusbar-h-padding = 12; # Prettier like that.
          guioptions = "sc"; # Always show the statusline and commandline
        };
        mappings = {
          # I dont want to be blind, but sometimes this can break documents.
          "$" = "recolor";
        };
      };

      # Set zathura as our default pdf reader.
      home.xdg = let
        zathuraMimeTypes = {
          "application/pdf" = ["org.pwmt.zathura.desktop" "qutebrowser.desktop"];
        };
      in {
        mimeApps.associations.added = zathuraMimeTypes;
        mimeApps.defaultApplications = zathuraMimeTypes;
      };

      # And enable theming for this.
      fht.theme.targets.zathura.enable = true;
    };
}
