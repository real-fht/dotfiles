{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.hardware.networking = {
    enable = mkBoolOpt' true "Whether to enable Networking via NetworkManager";
  };

  config = let
    cfg = config.fht.hardware.networking;
  in
    mkIf cfg.enable {
      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.macAddress = "random";
      # I ain't waiting 1m30s for networkmanager to setup my cards
      systemd.services.NetworkManager-wait-online.enable = false;

      # So my user can edit groups and stuff
      user.extraGroups = ["networkmanager"];
    };
}
