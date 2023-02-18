{
  inputs,
  pkgs,
  ...
}: {
  # Install agenix on the system.
  environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];

  # Let agenix know where is my secrets file.
  # Used to encrypt secrets and whatnot
  # age.secrets.secret1.file = ../
}
