# nixos-config

My simple NixOS configurations flake containing environments, scripts, and more.

#### Features:
 * Home-manager as a NixOS module unstable channel -> Earlier and more features, thus overall less issues than stable.
 * Home-manager as a NixOS module unstable channel -> Earlier and more features, thus overall less issues than stable.

## Environments
* Declarative configurations, including options, packages, programs, variables, etc

### Desktop
* Daily driver environments for a balanced gaming and development experience, suited for desktop workstations

#### Stale
FUSE type drives (ntfs and removable devices) don't work with the NixOS hardware detection method, and they are not added to the generated hardware configuration, and thus don't get added to fstab with this config.

For these you can try to mount with a compatible type manually (example: $ sudo mount -t ntfs3, instead of ntfs-3g or ntfs) and then with a few commands patch the hardware configuration after any hardware-configuration generation (you can replace the default hw config gen with an alias with the patch included, or create a program itself to manage it, etc). 

TODO:
1. Remove zsh aliases that are basically shell scripts. 
2. Tune hyprland options a little more, test a more aesthetic approach
3. Fix the zsh history and other options (do temporary setopt commands to check their behaviours before rebuilding the system)
4. Add vim keys for the zsh menu (check the Mental Outlaw zsh video again).
5. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration).
6. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc).
7. Check vimjoyer videos to keep adding to the system
8. Change colorscheme and theme of terminal, neovim and make the system match it
9. Check the programming language used for my installed pkgs (remove or replace rust ones)
10. Test different app launcher and file browser (lack of features on current ones)
11. Keep working on hyprland desktop (check useful utilities page and awersome hyprland repo)

### ISO
* Intended to be used for installation media (e.g usb stick), they contain some tools for ease of installation or recovery

#### Minimal
Contains some navigation tools and the installer script for a fast installation or recovery. Minimal program configuration

TODO:
1. Create basic installation script without disko
2. Learn to use disko if it makes the script easier

Setup a second beefier environment which is more comfortable for navigation (maybe including browser, etc) 


## Scripts
* Scripts in any language written with a nix wrapper (builder, writter, etc)

### Bash:
* It is my preferred shell scripting language (even if I use zsh as a shell) because:
1. Better documentation 
2. Simple syntax 
3. Has treesitter parsers and LSPs (unlike zsh)
4. Most used on all kinds of projects that use shell commands.
5. Available on virtually all Linux systems.

#### Installer
* A WIP fast and versatile NixOS installer which is packaged into my ISO environments

TODO:
1. Create a partition table (lsblk + read + fdisk or similar)
2. Format partitions (lsblk + read + mkfs)
3. Mount a drive with an input prompt (lsblk + read + mounting)
4. Generating a disko file by reading a fresh /etc/nixos/hardware-configuration.nix on the mounted drive
5. Call sudo nixos-install with specific options
6. Prompting for user password
7. Make a git directory in my user home, cloning my repos into it

Imperative installation (for reference):
1. Create partition table on disk (e.g. $ sudo cgdisk /dev/sda), no swap partition needed if swap file in desktop config
2. Format partitions (e.g. mkfs.* ...)
3. Mount formatted partitions
4. $ sudo nixos-generate-config --root /mnt && sudo cp /mnt/etc/nixos /etc/nixos
5. My current environment install: $ sudo nixos-install --impure --flake github:togwand/nixos-config/experimental#stale
6. (OPTIONAL): $ sudo nixos-enter and enter password for the user
