{lib, ...}:
# Custom option library.
# This just helps me avoid repetition when writing stuff.
with lib;
with lib.types; {
  mkOpt = type: default: mkOption {inherit type default;};

  mkOpt' = type: default: description:
    mkOption {inherit type default description;};

  mkBoolOpt = default:
    mkOption {
      inherit default;
      type = types.bool;
      example = true;
    };

  mkBoolOpt' = default: description:
    mkOption {
      inherit default description;
      type = types.bool;
      example = true;
    };
}
