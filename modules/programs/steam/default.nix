{
  config,
  lib,
  pkgs,
  ...
}:
# Steam module. nothing very interesting.
# Note that this was just copied and adapted from the official Steam module found
# in nixpkgs/nixos/modules/programs/steam.nix
with lib; {
  options.fht.programs.steam = with types; {
    enable = mkBoolOpt' false "Whether to enable steam.";

    remotePlay.openFirewall =
      mkBoolOpt' false "Open ports in the firewall for Steam Remote Play.";

    dedicatedServer.openFirewall =
      mkBoolOpt' false
      "Open ports in the firewall for Source Dedicated Server.";

    hardware.enable =
      mkBoolOpt' false
      "Enable additional hardware support for devices like the Steam controller";
  };

  config = let
    cfg = config.fht.programs.steam;
  in
    mkIf cfg.enable {
      # Enable hardware support.
      hardware.steam-hardware.enable = cfg.hardware.enable;

      # Install steam and steam run.
      user.packages = let
        steam = pkgs.steam.override {
          extraLibraries = pkgs:
            with config.hardware.opengl;
              if pkgs.hostPlatform.is64bit
              then [package] ++ extraPackages
              else [package32] ++ extraPackages32;
        };
      in [steam steam.run pkgs.protontricks];

      # Open firewall ports.
      networking.firewall = mkMerge [
        (mkIf cfg.remotePlay.openFirewall {
          allowedTCPPorts = [27036];
          allowedUDPPortRanges = [
            {
              from = 27031;
              to = 27036;
            }
          ];
        })

        (mkIf cfg.dedicatedServer.openFirewall {
          allowedTCPPorts = [27015]; # SRCDS Rcon port
          allowedUDPPorts = [27015]; # Gameplay traffic
        })
      ];
    };
}
