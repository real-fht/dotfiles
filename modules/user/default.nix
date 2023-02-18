{
  config,
  options,
  lib,
  ...
}:
# This module mission is to setup my user and it's home environment.
# It also sets up aliases for home manager options, to make things easier to
# deploy files and configuration to my home directory.
with lib; {
  options = with types; {
    # Links to my user defition at the system level (users.users.<name>)
    user = mkOpt' attrs {} "User definition.";

    # Links to my user home manager configuration.
    home = mkOpt' attrs {} "User home environent.";
  };

  config = {
    user = let
      # Get the current username from the $USER environment variable
      # Useful for anyone (besides me) setting up this flake.
      userFromEnv = builtins.getEnv "USER";
      name =
        if elem userFromEnv ["" "root"]
        then "real"
        else userFromEnv;
    in {
      inherit name;
      description =
        if name == "real"
        then "Nadjib Ferhat"
        else "System Account";
      extraGroups = ["wheel"];
      isNormalUser = true;
      home = "/home/${name}";
      group = "users";
      uid = 1000;
    };

    # -*- Initialise home-manager.
    home = {
      # Required for it to work (compatibility reasons.)
      home = {inherit (config.system) stateVersion;};
    };
    home-manager = {
      # Install user packages to /etc/profiles instead. Necessary for
      # nixos-rebuild build-vm to work.
      useUserPackages = true;

      # Initiate my user.
      users.${config.user.name} = mkAliasDefinitions options.home;
    };

    # Create the main user account.
    users.users.${config.user.name} = mkAliasDefinitions options.user;
    ## And put it inside the trusted and allowed users section.
    nix.settings = let
      users = ["root" config.user.name];
    in {
      trusted-users = users;
      allowed-users = users;
    };
  };
}
