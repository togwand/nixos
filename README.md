# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable as main output since stable is worse for my use case.

Imperative flake config installation (from installation media):

1. Create partition table and format disk (cgdisk)
2. Mount partitions (NixOS wiki install guide, no swap needed: 2GB file already declared)
4. $ sudo nixos-generate-config
5. $ sudo cp /mnt/etc/nixos/hardware-configuration.nix /etc/nixos
5. $ sudo nixos-install --impure --flake github:togwand/nixos-config/base#stale
6. $ sudo nixos-enter -c 'passwd togwand'

After any hardware change: $ sudo nixos-generate-config

TODO:
1. Put proggy fonts into the terminal
2. Choose a better monospace ttf or otf font
3. Move stuff around (my secrets wink wink)
4. Pick and configure shell (zsh or fish)
5. Check vimjoyer videos to keep adding to the system
6. Declarative installation method instead of imperative (need to research details)
