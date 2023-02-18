# `modules/` Custom NixOS modules.

This directory is all my custom NixOS modules that help me manage my systems more
efficiently. By creating custom modules in the `fht` namespace to make enabling/
disabling general options less repetitive.

## Directory structure.

| Directory/File     | Description/Utility                                               |
| ------------------ | ----------------------------------------------------------------- |
| `desktop/*/*.nix`  | Setup desktop related stuff (X.org, window managers, ...)         |
| `hardware/*/*.nix` | Hardware configuration/settings.                                  |
| `programs/*/*.nix` | Enable/Disable different programs, whether graphical or terminal. |
| `services/*/*.nix` | Enable/Disable different services.                                |
| `shared/*/*.nix`   | Shared configuration across hosts. (No related options)           |
| `theme/config/*`   | Setup theming across the system.                                  |
| `user/config/*`    | Setup my user and it's environment                                |
