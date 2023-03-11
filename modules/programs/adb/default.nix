{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.adb = {
    enable = mkBoolOpt' false "Whether to enable the Android Debug Program.";
  };

  config = let
    cfg = config.fht.programs.adb;
  in
    mkIf cfg.enable {
      # Just enable it.
      programs.adb.enable = true;
      user.extraGroups = ["adbusers"]; # Allow my user.
    };
}
