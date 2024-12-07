# nixos
My NixOS configurations and options

#### TODO
1. Change the options that depend on other programs to be in the same directory as the environment that used the other program (example hyprland uses firefox then move that option and similar ones to the directory of an environment instead of the main hyprland module, only hyprland only options in the hyprland module)
2. Test and add more nix options to all modules
3. Make a comfy live config
4. Make a server config type

## Desktop
Persistent NixOS for daily drive desktops with user-grade hardware

### stale
For gaming and dev (and of course, game dev) on a 2020 computer

#### TARGET SPECS
* Storage type: Crucial BX500 (x2) (NixOS & Windows/Games)
* Monitor: ViewSonic XG2402
* GPU: GTX 1650 Super
* CPU: i5-9400f

#### TODO
1. Fix theming of every part of the system, especially cursors and icons
2. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
3. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
4. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
5. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)
6. Check vimjoyer videos to keep adding to the system
7. Check the programming language used for my installed pkgs (remove or replace rust ones)

## Live
Non persistent NixOS ISO images for removable installation media

### lanky
For quick installation or recovery

## Modules
Additional NixOS configurations and options

### home-manager
Per user programs and services

### intel
Generic settings needed when the CPU used for a configuration is from Intel

### nvidia
Generic settings needed when the GPU used for a configuration is from Nvidia
