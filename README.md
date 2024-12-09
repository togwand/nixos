# nixos
My NixOS configurations and options

#### TODO
1. Check vimjoyer videos to learn more about nix options (and nix in general)
2. Test and add more nix options to all modules
3. Make a comfy live config
4. Make a server config type

## Desktop
Persistent NixOS for daily drive desktops with user-grade hardware

#### TODO
1. Find a way to make the xkbconfig more generic rather than forced (right now it's latam for every config)

### stale
For gaming and dev (and of course, game dev) on a 2020 computer

#### TARGET SPECS
* Storage type: Crucial BX500 (x2) (NixOS & Windows/Games)
* Monitor: ViewSonic XG2402
* GPU: GTX 1650 Super
* CPU: i5-9400f

#### TODO
1. Check the programming language used for my installed pkgs (remove or replace rust ones)
2. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
3. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
4. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
5. Fix theming of every part of the system, especially cursors and icons
6. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)

## Live
Non persistent NixOS ISO images for removable installation media

### lanky
For quick installation or recovery

## Modules
Always available to use NixOS options and optional configurations

### apps
Ready to use programs and services

### generic
Generic configurations needed for hardware or other modules

### inputs
Settings brought and used by this flake's inputs
