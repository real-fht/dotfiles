{pkgs ? import <nixpkgs> {}}: let
  # Custom nix shellscript that wraps the nixFlakes package nix binary and adds
  # the appropriate experimental features for flakes to work.
  nixBin = pkgs.writeShellScriptBin "nix" ''
    ${pkgs.nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
  '';
in
  pkgs.mkShell {
    buildInputs = with pkgs; [git nix-zsh-completions alejandra];
    shellHook = ''
      export FLAKE="$(pwd)"
      export PATH="${nixBin}/bin:$PATH"
    '';
  }
