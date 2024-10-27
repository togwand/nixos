# nixos-config

TODO: Declarative installation method instead of imperative/interactive (I know it's 100% doable but I haven't researched the details)

My simple NixOS configurations flake, using home-manager as a NixOS module. Only uakari and unstable versions as outputs for now.

This flake uses /etc/nixos/hardware-configuration.nix, keep it in sync with your current hardware and do not delete it.

Imperative steps to install the flake config from a generic NixOS installation media:

1. Partitioning the disk (I like using cgdisk for this task, and for steps 2-3.5 I use the installation guide of the NixOS wiki)
2. Formatting the partitions
3. Mounting the partitions (needed for step 4) -> Either enabling a swap partition or creating & enabling a swap file 

4. $ sudo nixos-generate-config --root (ROOT PARTITION MOUNT)
5. Pick one version to install. After it finishes, enter a root password:
    
    $ sudo nixos-install --flake github:togwand/nixos-config#unstable
    
    $ sudo nixos-install --flake github:togwand/nixos-config#uakari

6. $ sudo nixos-enter --root (ROOT PARTITION MOUNT) -c 'passwd togwand' -> Enter a password for togwand

7. $ reboot
8. Done, remember to use --impure to rebuild or install if it throws an error.

After any hardware changes run: $ sudo nixos-generate-config


