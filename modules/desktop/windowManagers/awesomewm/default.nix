{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; {
  options.fht.desktop.windowManagers.awesomewm = {
    enable = mkBoolOpt' false "Whether to enable AwesomeWM.";
  };

  config = let
    cfg = config.fht.desktop.windowManagers.awesomewm;
    pkg = pkgs.awesome-git.override {lua = pkgs.lua5_3;};
  in
    mkIf cfg.enable {
      # Enable awesomewm system-wide.
      services.xserver.windowManager.awesome = {
        enable = true;
        # Build awesoewm with lua 5.3 for some features and compat with some rocks.
        package = pkg;
        luaModules = with pkgs.lua53Packages; [lgi ldbus lua luarocks];
      };

      # Link my configuration.
      # home.home.activation.installAwesomeWMConfig = ''
      #   [ ! -d $XDG_CONFIG_HOME/awesome ] &&
      #     ln -s $DOTFILE_FLAKE/config/awesome $XDG_CONFIG_HOME/awesome
      # '';
      home.xdg.configFile."awesome".source = lib.files.mkOutOfStoreSymlink "/etc/nixos/config/awesome";

      # Link awesomewm modules.
      # home.xdg.configFile."awesome/modules/bling".source = inputs.bling.outPath;

      # Enable theming.
      fht.theme.targets.awesomewm.enable = true;
    };
}
