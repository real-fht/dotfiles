{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.fzf = {
    enable = mkBoolOpt' false "Whether to enable the FZF fuzzy finder";
  };

  config = let
    cfg = config.fht.programs.fzf;
    pkg = pkgs.fzf;
  in
    mkIf cfg.enable {
      home.programs.fzf = {
        enable = true;
        package = pkg;
        defaultOptions = [
          "--border=rounded" # Prettier
          "--layout=reverse" # Prompt at the top
          "--padding=5%" # Prettier too.
        ];
      };

      fht.shell.extraInit = ''
        # Initialise ZSH with fzf for interactive sessions.
        if [ ! -z $ZSH_VERSION ] && [ $options[zle] = "on" ]; then
          . ${pkg}/share/fzf/completion.zsh
          . ${pkg}/share/fzf/key-bindings.zsh
        fi
      '';

      # Enable custom theming or something.
      fht.theme.targets.fzf.enable = true;
    };
}
