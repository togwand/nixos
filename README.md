# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable since stable is still worse for my use case

# EVERYTHING BELOW THIS IS GOING TO BE OBSOLETE AFTER I FINISH MAKING MY PERFECT ISO AND PERFECT INSTALL SCRIPT AND PERFECT IMPERMANENT SETUP ON A DIFFERENT REPO 
Imperative flake config installation (from installation media):

1. Create partition table and format disk (e.g. $ sudo cgdisk /dev/sda), no swap needed (file declared in flake)
2. Mount partitions following NixOS wiki install guide 
3. $ sudo nixos-install --flake github:togwand/nixos-config/base#stale
4. $ sudo nixos-enter -c 'passwd togwand'
5. Reboot and clone this repo to add a symlink to flake.nix in /etc/nixos (same name)

# If the installation fails (can't boot or throws error before install finishes) and/or there are mismatches or missing options between this flake nixos.nix and $ sudo nixos-generate-config --root /mnt:
1. Keep following the NixOS wiki and perform the minimal installation
2. Add the git package to environment.systemPackages and enable flakes
3. On a new/empty directory do $ git clone https://github.com/togwand/nixos-config
4. Enter the cloned directory if you haven't and modify the cloned nixos.nix to match the generated hardware-configuration.nix options created by nixos-generate-config
5. $ sudo nixos-rebuild --flake .
6. Reboot and add a symlink from flake.nix on the cloned repo to /etc/nixos (same name)

# EVERYTHING ABOVE THIS IS GOING TO BE OBSOLETE AFTER I FINISH MAKING MY PERFECT ISO AND PERFECT INSTALL SCRIPT AND PERFECT IMPERMANENT SETUP ON A DIFFERENT REPO 

TODO:
1. Declarative installation method instead of imperative.
2. Needed on 7.: Use nixos-generate-config data somehow to match or add to the flake installation via script. Also need to generate the flake.nix symlink.
3. Fix the goddamn history options that never seem to work as I want, as well as adding vim keys for the menu for an actually faster experience with current aliases.
4. Add highlights, hooks, plugins, better completion and prompt to zsh.
5. Check vimjoyer videos to keep adding to the system
6. Check the programming language used for my installed pkgs (remove or replace rust ones)
7. Change colorscheme and theme of terminal, neovim and make the system match it
8. Test different app launcher and file browser (lack of features on current ones)
