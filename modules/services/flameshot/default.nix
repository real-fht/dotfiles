{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.services.flameshot = with types; {
    enable =
      mkBoolOpt' false "Whether to enable the Flameshot screenshot service.";
    savePath =
      mkOpt' str "${config.user.home}/Pictures/screenshots"
      "Where to save screenshots";
  };

  config = let
    cfg = config.fht.services.flameshot;
  in
    mkIf cfg.enable {
      home.services.flameshot = {
        enable = true;
        settings.General = {
          inherit (cfg) savePath;
          showHelp = false;
          showDesktopNotification = true;
          drawThickness = 2;
          saveAfterCopy = false;
        };
      };
    };
}
