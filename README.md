# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable since stable is still worse for my use case

Imperative flake config installation (from installation media):

1. Create partition table and format disk (cgdisk)
2. Mount partitions (NixOS wiki install guide, no swap needed because a file is declared)
3. Check mismatches between the flake and # nixos-generate-config --root /mnt
4. $ sudo nixos-install --flake github:togwand/nixos-config/base#stale
5. $ sudo nixos-enter -c 'passwd togwand'

TODO:
1. Configure zsh even more
2. Check vimjoyer videos to keep adding to the system
3. Change colorscheme and theme of terminal, neovim and make the system match it
4. Test different app launcher and file browser (lack of features on current ones)
5. Check the programming language used for my installed pkgs (remove or replace rust ones)
6. Declarative installation method instead of imperative (need to research details)
