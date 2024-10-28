# nixos-config

TODO: Declarative installation method instead of imperative/interactive (I know it's 100% doable but I haven't researched the details)

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable as output for now since uakari is worse for all my use cases.

This flake uses /etc/nixos/hardware-configuration.nix, keep it in sync with your current hardware and do not delete it.

Imperative steps to install the flake config from a generic NixOS installation media:

1. Partitioning the disk (I like using cgdisk for this task, and for steps 2-3.5 I use the installation guide of the NixOS wiki)
2. Formatting the partitions
3. Mounting the partitions (needed for step 4) -> Either enabling a swap partition or creating & enabling a swap file 

4. $ sudo nixos-generate-config --root (ROOT PARTITION MOUNT)
5. Pick one version to install. After it finishes, enter a root password. Example command:
    
    $ sudo nixos-install --flake github:togwand/nixos-config#unstable

6. $ sudo nixos-enter --root (ROOT PARTITION MOUNT) -c 'passwd togwand' -> Enter a password for togwand

7. $ reboot
8. Done, remember to use --impure to rebuild or install if it throws an error. 

For a generic NixOS installation media install to work you need to copy the hardware-configuration.nix file into the media /etc/nixos directory.

After any hardware changes it is recommended to run: $ sudo nixos-generate-config
