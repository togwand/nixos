# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable since stable is still worse for my use case

Imperative flake config installation (from installation media):

1. Create partition table and format disk (cgdisk)
2. Mount partitions (NixOS wiki install guide, no swap needed: 2GB file already declared)
3. $ sudo nixos-generate-config --root /mnt
4. $ sudo cp /mnt/etc/nixos/hardware-configuration.nix /etc/nixos
5. $ sudo nixos-install --impure --flake github:togwand/nixos-config/base#stale
6. $ sudo nixos-enter -c 'passwd togwand'

After any hardware change: $ sudo nixos-generate-config

TODO:
1. Configure zsh as much as I can
2. Check vimjoyer videos to keep adding to the system
3. Change colorscheme and theme of terminal, neovim and make the system match it
4. Test different app launcher and file browser (lack of features on current ones)
5. Check the programming language used for my installed pkgs
6. Declarative installation method instead of imperative (need to research details)
