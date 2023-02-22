{
  lib,
  inputs,
  ...
}: let
  inherit (import inputs.nixpkgs {system = "x86_64-linux";}) runCommandLocal;
  inherit
    (lib)
    filterAttrs
    mapAttrsToList
    flatten
    hasSuffix
    genList
    length
    lowerChars
    replaceStrings
    stringToCharacters
    upperChars
    ;
  inherit (builtins) readDir filter baseNameOf;
in {
  files = rec {
    # Helper functions to easily get files or directories from given path.
    get-files = path: let
      filtered-entries = filterAttrs (_: kind: kind == "regular") (readDir path);
      final = mapAttrsToList (name: _: "${toString path}/${name}") filtered-entries;
    in
      final;
    # -*-
    get-directories = path: let
      filtered-entries = filterAttrs (_: kind: kind == "directory") (readDir path);
      final = mapAttrsToList (name: _: "${toString path}/${name}") filtered-entries;
    in
      final;
    # -*-
    get-files-recursive = path: let
      # Get all files and directories of the given path this time.
      filtered-entries = filterAttrs (_: kind: (kind == "regular") || (kind == "directory")) (readDir path);
      map-file = name: kind:
        if kind == "directory"
        then get-files-recursive "${toString path}/${name}"
        else "${toString path}/${name}";
      final = flatten (mapAttrsToList map-file filtered-entries);
    in
      final;

    # Get the parent directory for a given path.
    get-parent-directory = path: baseNameOf (dirOf path);

    # Get normal and default nix files for imports.
    get-nix-files = path: filter (path: hasSuffix ".nix" (baseNameOf path)) (get-files path);
    get-nix-files-recursive = path: filter (path: hasSuffix ".nix" (baseNameOf path)) (get-files-recursive path);
    # -*-
    get-default-nix-files = path: filter (p: baseNameOf p == "default.nix") (get-files path);
    get-default-nix-files-recursive = path: filter (p: baseNameOf p == "default.nix") (get-files-recursive path);

    # Figures out a valid Nix store name for the given path.
    storeFileName = path: let
      # All characters that are considered safe. Note "-" is not
      # included to avoid "-" followed by digit being interpreted as a
      # version.
      safeChars =
        ["+" "." "_" "?" "="]
        ++ lowerChars
        ++ upperChars
        ++ stringToCharacters "0123456789";

      empties = l: genList (x: "") (length l);

      unsafeInName =
        stringToCharacters (replaceStrings safeChars (empties safeChars) path);

      safeName = replaceStrings unsafeInName (empties unsafeInName) path;
    in
      "hm_" + safeName;

    # To install configuration files.
    mkOutOfStoreSymlink = path: let
      pathStr = toString path;
      name = storeFileName (baseNameOf pathStr);
    in
      runCommandLocal name {} ''ln -s ${pathStr} $out'';
  };
}
