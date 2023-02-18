{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      # Use neovim nightly for my user, but the system still rolls on stable.
      neovim
      # Clipboard provider
      xclip
    ]
    ++ [
      # Lua language features
      sumneko-lua-language-server
      luajitPackages.luacheck
      stylua
    ]
    ++ [
      # Nix language features
      # rnix-lsp
      nil
      alejandra
    ]
    ++ [
      # Java/Typescript language features
      nodejs
      # nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.prettier
    ]
    ++ [
      # HTML/CSS/JSON language features
      nodePackages.vscode-langservers-extracted
    ];

  # Install my configuration
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "/etc/nixos/home/real/programs/terminal/neovim";

  # Setup coloring.
  xdg.configFile."theme/neovim/colors.lua".text = with import ../../../../../theme/colors.nix; ''
    ---@class ThemePalleteColors
    ---@field black        string
    ---@field darker_black string
    ---@field black2       string
    ---@field onebg        string
    ---@field oneb2        string
    ---@field oneb3        string
    ---@field statusline   string
    ---@field white        string
    ---@field grey         string
    ---@field grey_fg      string
    ---@field grey_fg2     string
    ---@field light_grey   string
    ---@field red          string
    ---@field green        string
    ---@field yellow       string
    ---@field blue         string
    ---@field magenta      string
    ---@field cyan         string

    ---@type ThemePalleteColors
    return {
        black        = "#${black}",
        darker_black = "#${darker_black}",
        black2       = "#${black2}",
        onebg        = "#${onebg}",
        oneb2        = "#${oneb2}",
        oneb3        = "#${oneb3}",
        statusline   = "#${statusline}",
        white        = "#${white}",
        grey         = "#${grey}",
        grey_fg      = "#${grey_fg}",
        grey_fg2     = "#${grey_fg2}",
        light_grey   = "#${light_grey}",
        red          = "#${red}",
        green        = "#${green}",
        yellow       = "#${yellow}",
        blue         = "#${blue}",
        magenta      = "#${magenta}",
        cyan         = "#${cyan}",
    }
  '';

  xdg.configFile."theme/neovim/base16.lua".text = with import ../../../../../theme/base16.nix; ''
    ---@class ThemePalleteBase16
    ---@field BASE00 string
    ---@field BASE01 string
    ---@field BASE02 string
    ---@field BASE03 string
    ---@field BASE04 string
    ---@field BASE05 string
    ---@field BASE06 string
    ---@field BASE07 string
    ---@field BASE08 string
    ---@field BASE09 string
    ---@field BASE0A string
    ---@field BASE0B string
    ---@field BASE0C string
    ---@field BASE0D string
    ---@field BASE0E string
    ---@field BASE0F string

    ---@type ThemePalleteBase16
    return {
        BASE00 = "#${base00}",
        BASE01 = "#${base01}",
        BASE02 = "#${base02}",
        BASE03 = "#${base03}",
        BASE04 = "#${base04}",
        BASE05 = "#${base05}",
        BASE06 = "#${base06}",
        BASE07 = "#${base07}",
        BASE08 = "#${base08}",
        BASE09 = "#${base09}",
        BASE0A = "#${base0A}",
        BASE0B = "#${base0B}",
        BASE0C = "#${base0C}",
        BASE0D = "#${base0D}",
        BASE0E = "#${base0E}",
        BASE0F = "#${base0F}",
    }
  '';
}
