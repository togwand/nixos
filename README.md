# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable as output since stable is worse for my use case.

This flake uses /etc/nixos/hardware-configuration.nix, keep it in sync with your current hardware and do not delete it.

Imperative steps to install the flake config from a generic NixOS installation media:

1. Partitioning the disk (I like using cgdisk for this task, and for steps 2-3.5 I use the installation guide of the NixOS wiki)
2. Formatting the partitions
3. Mounting the partitions (needed for step 4) -> Either enabling a swap partition or creating & enabling a swap file
4. $ sudo nixos-generate-config --root (ROOT PARTITION MOUNT)
5. Pick one version to install. After it finishes, enter a root password. Example command: $ sudo nixos-install --flake github:togwand/nixos-config#unstable
6. $ sudo nixos-enter --root (ROOT PARTITION MOUNT) -c 'passwd togwand' -> Enter a password for togwand
7. $ reboot
8. Done, remember to use --impure to rebuild or install if it throws an error. 

For a generic NixOS installation media install to work you need to copy the hardware-configuration.nix file into the media /etc/nixos directory.

After any hardware changes it is recommended to run: $ sudo nixos-generate-config

TODO:

1. Pick plymouth theme, configure a display (session) manager and choose font options that remove blurriness on certain spots.
2. Choose a better mono font than 0xProto, install more special characters and emoji fonts
3. Pick and configure shell (zsh or fish)
4. Check vimjoyer videos to keep adding to the system
5. Declarative installation method instead of imperative/interactive (I know it's 100% doable but I haven't researched the details)
