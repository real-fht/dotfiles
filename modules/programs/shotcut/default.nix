{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.shotcut = {
    enable = mkBoolOpt' false "Whether to enable the Shotcut video editor.";
  };

  config = let
    cfg = config.fht.programs.shotcut;
  in
    mkIf cfg.enable {
      # Just install it ffs.
      user.packages = [pkgs.shotcut];
    };
}
