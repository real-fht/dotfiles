{
  lib,
  inputs,
}: let
  inherit (lib) assertMsg concatMap fix hasSuffix foldl hasInfix;
  inherit (lib.files) get-parent-directory get-directories get-default-nix-files-recursive;

  virtual-systems = import ./virtual-systems.nix;

  get-inferred-system-name = path:
    if hasSuffix "nix" path
    then get-parent-directory path
    else baseNameOf path;
in {
  system = rec {
    # Get the virtual system type of a system target.
    get-virtual-system-type = target:
      foldl
      (
        result: virtual-system:
          if result == "" && hasInfix virtual-system target
          then virtual-system
          else result
      )
      ""
      virtual-systems;
    # Get structured data about all systems for a given target.
    get-target-systems-metadata = target: let
      systems = get-directories target;
      existing-systems = builtins.filter (system: builtins.pathExists "${system}/default.nix") systems;
      create-system-metadata = path: {
        path = "${path}/default.nix";
        # Nix doesn't like assigning paths to variables in flake's pure mode, so we need
        # to explicitly discard the ath string.
        name = builtins.unsafeDiscardStringContext (builtins.baseNameOf path);
        target = builtins.unsafeDiscardStringContext (builtins.baseNameOf target);
      };
      system-configurations = builtins.map create-system-metadata existing-systems;
    in
      system-configurations;
    # Get the system builder for a given target.
    get-system-builder = target: let
      virtual-system-type = get-virtual-system-type target;
      virtual-system-builder = args:
        assert (assertMsg (inputs ? nixos-generators) "In order to create virtual systems, you must include `nixos-generators` as a flake input.");
          inputs.nixos-generators.nixosGenerate
          (args
            // {
              format = virtual-system-type;
              specialArgs =
                args.specialArgs
                // {
                  format = virtual-system-type;
                };
            });
      linux-system-builder = args:
        lib.nixosSystem (args // {specialArgs = args.specialArgs // {format = "linux";};});
    in
      if virtual-system-type != ""
      then virtual-system-builder
      else linux-system-builder;

    # Get the flake output attribute for a system target.
    get-system-output = target: let
      virtual-system-type = get-virtual-system-type target;
    in
      if virtual-system-type != ""
      then "${virtual-system-type}Configurations"
      else "nixosConfigurations";

    # Get the resolved (non-virtual) system target.
    get-resolved-system-target = target: let
      virtual-system-type = get-virtual-system-type target;
    in
      if virtual-system-type != ""
      then builtins.replaceStrings [virtual-system-type] ["linux"] target
      else target;

    # Loads a nixos module from a direcotory using the 1st sub directory name as the
    # module name, and loads all sub directories/files from the 1st sub dir.
    get-nixos-modules = modulesPath: let
      modules-list = map (modulePath: baseNameOf modulePath) (get-directories modulesPath);
      modules-data = foldl (accum: module:
        accum
        // {
          "${builtins.unsafeDiscardStringContext module}".imports =
            get-default-nix-files-recursive "${toString modulesPath}/${module}";
        }) {}
      modules-list;
    in
      modules-data;

    # Create a system.
    create-system = {
      target ? "x86_64-linux",
      system ? get-resolved-system-target target,
      path,
      name ? builtins.unsafeDiscardStringContext (get-inferred-system-name path),
      modules ? [],
      channelName ? "nixpkgs",
      builder ? get-system-builder target,
      output ? get-system-output target,
      systems ? {},
    }: {
      inherit channelName system builder output;

      modules = [path] ++ modules;
      specialArgs = {inherit system systems;};
    };

    # Generate all available systems.
    create-systems = systemsPath: let
      # Get all the available targets from given system path.
      targets = get-directories systemsPath;
      # Generate appropriate metadata with name path and target
      target-systems-metadata = concatMap get-target-systems-metadata targets;
      # TODO: Automatically load modules.
      create-system' = created-systems: system-metadata: {
        ${system-metadata.name} = create-system (system-metadata // {systems = created-systems;});
      };
      created-systems = fix (created-systems: foldl (systems: system-metadata: systems // (create-system' created-systems system-metadata)) {} target-systems-metadata);
    in
      created-systems;
  };
}
