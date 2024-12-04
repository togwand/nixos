# nixos-config
Nix flake for my NixOS configurations, including environments, modules, scripts and more

### Inputs
 * nixpkgs/nixos-unstable -> Earlier and more features, overall less issues than stable
 * disko/master -> For an easier and more reliable way to install NixOS as well as not using generated filesystems
 * home-manager/master -> Some apps are easier to configure with it (e.g. zsh, hyprland)
 * nixvim/main -> Very modular and fairly easy to modify, also adds several inputs to the flake (e.g. treefmt)
   * treefmt-nix -> Allows for an easy and informative formatting of any language in the flake

TODO:
1. stale (1-2)
2. nixos-installer
3. shell-manager
4. scripts
5. modules
6. environments

## Environments
NixOS configurations including system options, submodules, packages and variables

TODO:
1. Make a comfy iso environment
2. Make a server environment

#### minimal_iso
tty + nixos-installer configuration for a fast and easy installation

#### stale
Hyprland + shell-manager configuration to enhance my workflow

TODO:
1. Creating custom monitor display modes/modelines on wayland
2. Check all environment variables in the hyprland wiki page to enable them in the system config
3. Fix theming of every part of the system, especially cursors and icons
4. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
5. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
6. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
7. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)
8. Check vimjoyer videos to keep adding to the system
9. Check the programming language used for my installed pkgs (remove or replace rust ones)

## Modules
Nix overlays, configurations, and more which are toggleable with custom options

TODO:
1. Change the options that depend on other programs to be in the same directory as the environment that used the other program (example hyprland uses firefox then move that option and similar ones to the directory of an environment instead of the main hyprland module, only hyprland only options in the hyprland module)
2. Make options for enable/disable options inside the configuration of modules (ex for minimal iso versus desktop environments)
3. Test and add more nix options to all modules

#### home-manager
Home-manager configurations for programs and services

#### overlays
Derivations built with a nix writer or similar builder, one overlay per derivation

#### treefmt-nix
All the flake language formatters and their configurations

## Scripts
Executable and portable* code not written in nix

* Not technically portable as the shebang is declared in a module

TODO
1. Change names to be more fun

#### shell-manager
An interactive shell command manager

TODO
1. Finish the help section (descriptions for menu commands)

#### nixos-installer
An interactive NixOS installer

TODO
1. Refactor as with the shell-manager
