{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    pkgs.lua5_3 # Lua version of awesome.
  ];
  nativeBuildInputs = [
    pkgs.stylua # Formatting.
    pkgs.lua53Packages.luacheck # Linter
    pkgs.sumneko-lua-language-server # Lsp
  ];
}
