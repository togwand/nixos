# nixos
My NixOS configurations and options

#### TODO
1. Learn more about nix (vimjoyer+official documentation)
2. Replace with pkgs; or similar with inherit ()
3. Test and add more nix options to all modules
4. Make a comfy live config
5. Make a server config type

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
1. Move xdg.MimeApps out of lf module
2. Add options for wandpkgs programs (needed in lf module)
3. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
4. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
5. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
6. Add mpv to apps as a home-manager program
7. Fix theming of every part of the system, especially cursors and icons
8. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)

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

## Pictures
External images or similar media that some modules use (e.g. backgrounds)
