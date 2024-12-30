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
1. Work on the default programs for mime types (add mpv)
2. Make a better waybar style (using css)

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
