# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only uakari and unstable versions for now.

This flake uses /etc/nixos/hardware-configuration.nix, keep it in sync with your current hardware and do not delete it.

TODO: Declarative installation method instead of imperative/interactive (I know it's 100% doable but I haven't researched the specifics)

Imperative steps to install the flake config from a generic NixOS installation media:

1. Partitioning the disk (I like using cgdisk for this task, and for steps 2-3.5 I use the installation guide of the NixOS wiki)
2. Formatting the partitions 
3. Mounting the partitions (needed for step 4)
3.5 Either enabling a swap partition or creating & enabling a swap file 
4. # nixos-generate-config --root <ROOT PARTITION MOUNT> 
5. Pick one version to install:
    # nixos-install --flake github:togwand/nixos-config#unstable
    # nixos-install --flake github:togwand/nixos-config#uakari
5.5. Enter a password for root 
6. # nixos-enter --root <ROOT PARTITION MOUNT> -c 'passwd togwand'
6.5. Enter a password for togwand
7. $ reboot... and remove installation media before boot loader screen
8. Done, after any hardware changes run: # nixos-generate-config
