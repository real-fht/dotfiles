{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; {
  options.fht.programs.neovim = {
    enable = mkBoolOpt' true "Whether to enable the Neovim editor.";
  };

  config = let
    cfg = config.fht.programs.neovim;
  in
    mkIf cfg.enable {
      # Install neovim with various packages that provide language features such
      # as completion, linting, diagnostics, etc...
      # TODO: Maybe create a lang.<name> module?
      user.packages = with pkgs;
        [
          inputs.neovim-nightly.packages.${pkgs.system}.neovim
          xclip # Clipboard provider
          ripgrep # Regex matcher, for telescope and other plugins
          fd # File finder, for telescope and filetree
        ]
        ++ [
          sumneko-lua-language-server # Lua language features
          luajitPackages.luacheck # Lua checking and linting
          stylua # Lua formatting
        ]
        ++ [
          nil # Nix language features (but not completion)
          alejandra # Nix formatting
        ]
        ++ (with nodePackages; [
          typescript-language-server # Javascript/Typescript language features
          prettier # JS/TS and other languages formatting
        ])
        ++ [
          # CSS/HTML/JSON(C) language features
          # Prettier handles formatting
          nodePackages.vscode-langservers-extracted
        ];

      # Install my configuration
      home.xdg.configFile."nvim".source = lib.files.mkOutOfStoreSymlink "/etc/nixos/config/nvim";

      # Install colorscheme for Neovim.
      fht.theme.targets.neovim.enable = true;

      # Set neovim as our default editor.
      environment.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
    };
}
