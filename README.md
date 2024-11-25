# nixos-config
Nix flake for my NixOS configurations, including environments, modules, scripts and more

### Inputs
 * nixpkgs/nixos-unstable -> Earlier and more features, overall less issues than stable
 * disko/master -> For an easier and more reliable way to install NixOS as well as not using generated filesystems
 * home-manager/master -> Some apps are easier to configure with it (e.g. zsh, hyprland)
 * nixvim/main -> Very modular and fairly easy to modify

### Formatter
 * nixfmt -> Might not be compact but it's consistent and fast

TODO:
1. stale
2. shell-manager
3. modules
3. nixos-installer
4. environments

## Environments
NixOS configurations including system options, submodules, packages and variables

TODO:
1. Make a comfy iso environment

### minimal_iso
tty + nixos-installer configuration for a fast and easy installation

### stale
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

## Modules
Nix overlays, configurations, and more which are toggleable with custom options

TODO:
1. Test and add more nix options to all modules

### home-manager
Home-manager programs configurations

### overlays
Derivations built with a nix writer or similar builder, one overlay per derivation

## Scripts
Executable and portable* code not written in nix 

* Not technically portable as the shebang is declared in a module

#### shell-manager
An interactive shell command manager

TODO:
1. Add function to swap between root and not root (with a restart of the program perhaps)
2. Better git options and aggregate its commands into functions
3. Upgrade help section and add manpage/documentation
4. Make prettier somehow

#### nixos-installer
An interactive NixOS installer

TODO:
1. Add functions or options for better customization
2. Better help section
