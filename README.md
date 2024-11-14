# nixos-config

My simple NixOS configurations flake, using home-manager as a NixOS module. Only unstable since stable is still worse for my use case

FUSE type drives (ntfs and removable devices) don't work with the NixOS hardware detection method, and they are not added to the generated hardware configuration, and thus don't get added to fstab with this config.

For these you can try to mount with a compatible type manually (example: $ sudo mount -t ntfs3, instead of ntfs-3g or ntfs) and then with a few commands patch the hardware configuration after any hardware-configuration generation (you can replace the default hw config gen with an alias with the patch included, or create a program itself to manage it, etc). 

TODO:
1. Declarative installation method instead of imperative.
2. Replace ALL the complex zsh aliases with bash scripts. 
3. Fix the zsh history and other options (do temporary setopt commands to check their behaviours before rebuilding the system)
4. Add vim keys for the zsh menu (check the Mental Outlaw zsh video again).
5. Add highlights, hooks, plugins, better completion and prompt to zsh (finish the configuration).
6. Work on the nixvim config (line wrapping, autotabbing/formatting, and keybinds, macros, etc).
7. Check vimjoyer videos to keep adding to the system
8. Change colorscheme and theme of terminal, neovim and make the system match it
9. Check the programming language used for my installed pkgs (remove or replace rust ones)
10. Tune hyprland options a little more, test a more aesthetic approach
11. Test different app launcher and file browser (lack of features on current ones)
12. Keep working on hyprland desktop (check useful utilities page and awersome hyprland repo)
