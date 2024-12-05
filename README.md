# nixos-config
Nix flake for my NixOS configurations, including environments, modules, scripts and more

### Inputs
 * nixpkgs/nixos-unstable -> Earlier and more features, overall less issues than stable
 * disko/master -> For an easier and more reliable way to install NixOS as well as not using generated filesystems
 * home-manager/master -> Some apps are easier to configure with it (e.g. zsh, hyprland)
 * nixvim/main -> Very modular and fairly easy to modify, also adds several inputs to the flake (e.g. treefmt)
   * treefmt-nix -> Allows for an easy and informative formatting of any language in the flake

TODO:
1. modules
2. shell-manager
3. nixos-installer
4. scripts
5. environments

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
1. Fix theming of every part of the system, especially cursors and icons
2. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
3. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
4. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
5. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)
6. Check vimjoyer videos to keep adding to the system
7. Check the programming language used for my installed pkgs (remove or replace rust ones)

## Modules
Nix overlays, configurations, and more which are toggleable with custom options

TODO:
1. Make the modules... more modular (separate current modules into more modules)
2. Recheck all content and identify issues with reinstallations and hard-coded values for hardware and similar issues
3. Change the options that depend on other programs to be in the same directory as the environment that used the other program (example hyprland uses firefox then move that option and similar ones to the directory of an environment instead of the main hyprland module, only hyprland only options in the hyprland module)
4. Make options for enable/disable options inside the configuration of modules (ex for minimal iso versus desktop environments)
5. Test and add more nix options to all modules

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
1. Make all the commands not start with the confirm but by reading the neccesary and then confirming each important step, like I did with nixos rebuild
2. Make a rclone section for sure and fast method to copy and synsc my stuff after changes after changes
3. Finish the help section (descriptions for menu commands)

#### nixos-installer
An interactive NixOS installer

TODO
1. Add a way to silently do ntfsfix -db to all partitions with a ntfs filesystem?
2. Refactor as with the shell-manager
