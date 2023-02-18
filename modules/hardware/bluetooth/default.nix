{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.fht.hardware.bluetooth = {
    enable = mkBoolOpt' false "Whether to enable Bluetooth support";
  };

  config = let
    cfg = config.fht.hardware.bluetooth;
  in
    mkIf cfg.enable {
      hardware.bluetooth = {
        enable = true;
        # Includes additional utilities for bluetooth.
        package = pkgs.bluezFull;
      };
    };
}
