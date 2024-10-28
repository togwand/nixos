{
  user,
  pkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        imports = [
          ./home/git.nix
          ./home/neovim.nix
          ./home/hyprland.nix
          # PICK AND CONFIGURE ANOTHER TERMINAL EMULATOR
          # PICK AND CONFIGURE ANOTHER SHELL
          ./home/swaync.nix
          ./home/fuzzel.nix
          ./home/mangohud.nix
          ./home/gtk.nix
        ];
        programs = {
          home-manager.enable = true;
          kitty.enable = true; # Config pending
          firefox.enable = true; # Config pending
        };
        home = {
          packages = with pkgs; [
            rclone
            pavucontrol
            discord
          ];
          file = {};
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = "24.05";
        };
      };
    };
  };
}
