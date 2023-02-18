{
  lib,
  pkgs,
  ...
}:
# Some nix settings for this configuration to work and self-maintain itself.
{
  # Since there's packages that aren't free and open source..
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Clean old derivations from the store.
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 7d";
    # And optimise the store automatically too.
    optimise.automatic = true;
    optimise.dates = ["weekly"];

    # Enable flake support using an unstable nix version *system-wide*
    # TODO: Maybe create a shell.nix at the root of this repo that have the an alias
    # for this?
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    settings = {
      auto-optimise-store = true;
      cores = 8; # Faster rebuilding
      max-jobs = 8; # ^^^^
      flake-registry = "/etc/nix/registry.json";

      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://fortuneteller2k.cachix.org"
        "https://webcord.cachix.org"
        "https://nix-gaming.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "webcord.cachix.org-1:l555jqOZGHd2C9+vS8ccdh8FhqnGe8L78QrHNn+EFEs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };

  # I don't need this at all;
  system.autoUpgrade.enable = false;
}
