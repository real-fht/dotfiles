# flake.nix -*- The beautiful (or rather ugly) initialisation of my dotfiles.
# Welcome to the base of this configuration. Includes configuration for some devices
# and my only user, etc...
# ---
# Author:  Nadjib Ferhat <nferhat20@gmail.com>
# URL:     https://github.com/real-fht/dotfiles
# License: MIT
{
  description = "@real-fht system configuration";

  inputs = {
    # Nixpkgs as the core of the flake, includes packages and base nixos modules
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Unified configuration for systems, packages, modules, shells, templates, and more with Nix Flakes.
    # Very useful to avoid repetition.
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";

    # Home manager so I can deploy configuration files and settings to my user's
    # **home** directory using nix.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage and encrypt secrets using my ssh keys.
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Block garbage urls easily with a configuration flag.
    # FIXME: Not working somehow? (the flake)
    # hosts.url = "github:StevenBlack/hosts";

    # Additional nixpkgs overlays
    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    # Non-flake inputs.
    bling = {
      url = "github:BlingCorp/bling";
      flake = false;
    };
  };

  outputs = {
    self,
    flake-utils-plus,
    ...
  } @ inputs: let
    # Extend the base nixpkgs library with my personal library functions
    my_lib = import ./lib inputs;
    lib = inputs.nixpkgs.lib.extend (self: super: my_lib);
  in
    flake-utils-plus.lib.mkFlake rec {
      inherit self inputs lib; # required.

      # Only build for 64-bit Linux systems, aka: AMD64, x86_64-linux.
      supportedSystems = ["x86_64-linux"];

      # Generate $NIX_PATH, the Nix registry with our inputs, and symlink them to
      # /etc/nix/inputs for easier access and available documentation.
      nix.generateNixPathFromInputs = true;
      nix.generateRegistryFromInputs = true;
      nix.linkInputs = true;

      # --- Setup channels ---
      # Since some drivers (nvidia, duh) and packages (discord, telegram, ...)
      # are not free and open source... (forgive me RMS)
      channelsConfig.allowUnfree = true;
      # Create a "stable" channel that is going to be the default for all my systems.
      channels.nixpkgs.input = inputs.nixpkgs;
      # Shared overlays between channels.
      sharedOverlays = with inputs; [
        nixpkgs-f2k.overlays.default
        (final: prev: {
          fht = builtins.listToAttrs (builtins.map (package: {
            name = builtins.unsafeDiscardStringContext (lib.files.get-parent-directory package);
            value = prev.callPackage package {inherit channels lib;};
          }) (lib.files.get-default-nix-files-recursive ./packages));
        })
      ];

      # --- Host configuration. ---
      # Default channel for the hosts.
      # You can use another channel than the default by accessing the channels
      # argument passed to host configurations.
      hostDefaults.channelName = "nixpkgs";
      # Import all my nixos modules.
      nixosModules = lib.system.get-nixos-modules ./modules;
      # Allow all my hosts to access inputs and lib.
      hostDefaults.extraArgs = {inherit lib inputs;};
      hostDefaults.specialArgs = {inherit lib inputs;};
      # Shared confifuration accross my hosts.
      hostDefaults.modules = with inputs;
        [
          home-manager.nixosModules.default # to manage and deploy configuration for my user
          agenix.nixosModules.default # encrypting secrets using nix
          # hosts.nixosModule # block garbage urls and websites.
        ]
        ++ (lib.attrValues nixosModules);
      # Initiate all my hosts.
      hosts = lib.system.create-systems ./systems;
    };
}
