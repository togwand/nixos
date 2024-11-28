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
4. environments

## Environments
NixOS configurations including system options, submodules, packages and variables

TODO:
1. Make a comfy iso environment

#### minimal_iso
tty + nixos-installer configuration for a fast and easy installation

#### stale
Hyprland + shell-manager configuration to enhance my workflow

1. Fix the zsh options including history and others (do temporary setopt commands for testing behaviours before rebuilds)
2. Add vim keys for the zsh menu (check Mental Outlaw's trying zsh video again)
3. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration)
4. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc)
5. Check vimjoyer videos to keep adding to the system
6. Change colorscheme and theme of terminal, neovim and make the system match it
7. Check the programming language used for my installed pkgs (remove or replace rust ones)

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

## Scripts
Executable and portable* code not written in nix 

* Not technically portable as the shebang is declared in a module

#### shell-manager
An interactive shell command manager

TODO:
1. git diff to be git diff HEAD or git diff --staged
2. Set the flake to be used to be a remote one instead of local
3. Make the options be abortable/cancellable with ctrl+c without exiting the program 
4. Add function to swap between root and not root (with a restart of the program perhaps)
5. Better git options and aggregate its commands into functions

#### nixos-installer
An interactive NixOS installer
