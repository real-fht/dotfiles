inputs: let
  # The way I load the library functions from here is inspired and copied from
  # snowfall-lib, very interesting way.
  inherit (inputs.nixpkgs.lib) fix fold recursiveUpdate makeExtensible filterAttrs mapAttrs hasInfix;
  inherit
    ((import ./files {
        inherit (inputs.nixpkgs) lib;
        inherit inputs;
      })
      .files)
    get-default-nix-files-recursive
    ;
  inherit (builtins) map removeAttrs isAttrs filter;

  # Recursively merge a list of attribute sets.
  merge-deep = fold recursiveUpdate {};

  # Get library from flake inputs to extend the base nixpkgs lib with them.
  flake-input-libs = let
    filtered-inputs = filterAttrs (n: v: isAttrs (v.lib or null)) (removeAttrs inputs ["self"]);
    libs-from-inputs' = mapAttrs (n: input: input.lib) filtered-inputs;
  in
    libs-from-inputs';

  # Import and parse all my nix files
  personal-lib-files = filter (path: !hasInfix "lib/default.nix" path) (get-default-nix-files-recursive ./.);
  personal-lib = fix (user-lib: let
    attrs = {
      inherit inputs;
      # This hacky method allows me to use my already existing library functions inside
      # other library functions, but still get the nixpkgs base library.
      lib = user-lib // inputs.nixpkgs.lib;
    };
    libs = map (path: import path attrs) personal-lib-files;
  in
    merge-deep libs);

  # Make it a extensible because I maybe will want to override more stuff in the
  # future, idfk. like inside the modules of the system.
  final-lib = makeExtensible (super:
    personal-lib
    // flake-input-libs
    // {inherit inputs;});
in
  final-lib
