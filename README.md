# nixos-config
NixOS flake with environments, scripts, and more

## Features
 * environments -> NixOS configurations for desktop & iso
 * scripts -> NixOS overlays for bash

### Inputs
 * nixpkgs/nixos-unstable -> Earlier and more features, overall less issues than stable
 * home-manager/master -> Some apps are easier to configure with it (e.g. zsh, hyprland)
 * nixvim/main -> Very modular and fairly easy to modify

### Formatter
 * nixfmt -> Might not be compact but it's consistent and fast

TODO:
1. nixos-installer (1-2)
2. shell-manager (1)
3. stale (1-5)
4. nixos-installer (3)
5. stale (6-10)
6. shell-manager (2-3)
7. iso (1)

## Environments
Declarative configurations, including options, packages, programs, variables, etc

### Desktop
Desktop workstation environments for a balanced gaming + development experience

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

### ISO
Installation media environments with tools for installation and recovery

TODO:
1. Setup a second beefier environment which is more comfortable for navigation (maybe including browser, etc)

#### minimal
tty + nixos-installer configuration for a fast and easy installation

## Scripts
They become binaries by using NixOS writeScriptBin (custom shebang) & overlays (very modular)

### Bash
#### shell-manager
An interactive NixOS shell command manager

TODO:
1. Add ntfs detection and mounting as ntfs3 (with error checking) before patching hardware config
2. Upgrade help section and add manpage/documentation
3. Make prettier somehow

#### nixos-installer
An interactive NixOS installer

TODO:
1. Finish a basic installer (without disko)
2. Learn disko and put it into the flake_install function
3. Make the installation be impermanent
