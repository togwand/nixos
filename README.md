# nixos
My NixOS configurations and options

#### TODO
1. Learn more about nix (vimjoyer+official documentation)
2. Replace "with pkgs;" or similar with "inherit ()"
3. Test and add more nix options to all modules
4. Make a comfy live config
5. Make a server config type

## Derivations
Nix derivations of git repositories

#### TODO
1. For programs or scripts, make derivations with dependencies and all build steps

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
1. Fix the lang when using xdg-open for text instead of "e" on lf
2. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
3. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
4. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
5. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)
6. Configure bash to be as close to (the finished) zsh as possible
7. Add mpv to apps as a home-manager program and work on the default programs for mime types
8. Make waybar prettier with a better style (need to learn more about css too)
9. Fix theming of every part of the system, especially cursors and icons

## Live
Non persistent NixOS ISO images for removable installation media

### lanky
For quick installation or recovery

#### TODO
1. Test it again sometime in the future when my current installation is too bloated

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
