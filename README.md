# nixos-config
NixOS flake with environments, scripts, and more

### Inputs
 * disko/master -> For an easier and more reliable way to install NixOS as well as not generating-nixos-config
 * home-manager/master -> Some apps are easier to configure with it (e.g. zsh, hyprland)
 * nixpkgs/nixos-unstable -> Earlier and more features, overall less issues than stable
 * nixvim/main -> Very modular and fairly easy to modify

### Formatter
 * nixfmt -> Might not be compact but it's consistent and fast

TODO:
1. Reestructure and modularize directories
2. Add disko as an input to flake
3. nixos-installer
4. stale
5. shell-manager
6. environments

## Modules
Nix files including derivations, functions and configurations

### Environments
NixOS configurations including system options, submodules, packages and variables

TODO:
1. Make a comfy iso environment

#### minimal_iso
tty + nixos-installer configuration for a fast and easy installation

#### stale
Hyprland + shell-manager configuration to enhance my workflow

TODO:
1. Tune hyprland options a little more, test a more aesthetic approach
2. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
3. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
4. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
5. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)
6. Check vimjoyer videos to keep adding to the system
7. Change colorscheme and theme of terminal, neovim and make the system match it
8. Check the programming language used for my installed pkgs (remove or replace rust ones)
9. Test different app launcher and file browser (lack of features on current ones)
10. Keep working on hyprland desktop (check useful utilities page and awersome hyprland repo)

## Scripts
Code not written in nix used as inputs for a nix overlays + writeScriptBin module

#### shell-manager
An interactive shell command manager

TODO:
1. Upgrade help section and add manpage/documentation
2. Make prettier somehow

#### nixos-installer
An interactive NixOS installer

TODO:
1. Learn disko and put it into the flake_install function
2. Make more modular, add functions for repeates stuff and simplify code 
3. Better help section
