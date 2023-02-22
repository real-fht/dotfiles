{
  config,
  lib,
  pkgs,
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
        [neovim xclip ripgrep fd]
        ++ [sumneko-lua-language-server luajitPackages.luacheck stylua]
        ++ [nil alejandra]
        ++ (with nodePackages; [typescript-language-server prettier])
        ++ [nodePackages.vscode-langservers-extracted];

      # Install my configuration
      home.xdg.configFile."nvim".source = lib.files.mkOutOfStoreSymlink "/etc/nixos/config/nvim";

      # Install colorscheme for Neovim.
      fht.theme.targets.neovim.enable = true;

      # Set neovim as our default editor.
      environment.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
    };
}
