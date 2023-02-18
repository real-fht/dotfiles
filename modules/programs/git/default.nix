{
  config,
  lib,
  ...
}:
with lib; {
  options.fht.programs.git = with types; {
    enable = mkBoolOpt' false "Whether to enable git.";
    userEmail = mkOpt' str "" "Your e-mail address for git.";
    userName = mkOpt' str "" "Your username for git.";
  };

  config = let
    cfg = config.fht.programs.git;
  in
    mkIf cfg.enable {
      # Enable and configure git system-wide, since I use it with the root user too.
      programs.git = {
        enable = true;
        # Basic settings for my sanitfy.
        config = {
          init.defaultBranch = "main"; # the new convention
          core.ignoreCase = true;
          core.symlinks = true; # never trust/handle symlinks
          core.editor = "$EDITOR";
          url = {
            # Url substitutions, very useful.
            "https://github.com/".insteadOf = ["gh:" "github:"];
          };
        };
      };

      # Deploy some local more advanced configuration for my user.
      # Located inside ~/.config/git/
      home.programs.git = {
        inherit (cfg) userName userEmail;
        enable = true;

        # Easier for my fingers, even though I have aliases in my zshrc
        aliases = {
          add-select = "!git status --short | fzf | awk '{print $2}' | xargs -r git add";
          br = "branch";
          ba = "branch --all";
          bd = "branch -D";
          ca = "commit --all";
          ci = "commit";
          cl = "clone";
          co = "checkout";
          cp = "cherry-pick";
          st = "status";
          hist = "log --all - graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'";
          llog = "log --graph --name-status --pretty=format:'%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset' --date=relative";
          ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
          pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
          af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
        };

        # Default ignores I guess.
        ignores = ["node_modules" "*.swp" "*~" "__pycache__" "target"];
      };

      # Additional shell aliases.
      fht.shell.aliases = {
        g = "git";
        gc = "git commit";
        gco = "git checkout";
        ga = "git add";
        gaa = "git add -A";
        gA = "git add -A";
        gb = "git branch";
        gba = "git branch --all";
        gbd = "git branch -D";
        gd = "git diff -w";
        gds = "git diff -w --staged";
        gcp = "git cherry-pick";
        grs = "git restore --staged";
        gst = "git rev-parse --git-dir > /dev/null 2>&1 && git status || exa";
        gu = "git reset --soft HEAD~1";
        gpr = "git remote prune origin";
        ff = "gpr && git pull --ff-only";
        grd = "git fetch origin && git rebase origin/master";
        gbf = "git branch | head -1 | xargs";
        git-current-branch = ''git branch | grep  ;* | cut -d " " -f2'';
        grc = "git rebase --continue";
        gra = "git rebase --abort";
        gec = ''
          git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs $EDITOR -'';
      };
    };
}
