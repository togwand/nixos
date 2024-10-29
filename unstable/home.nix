{
  pkgs,
  user,
  nxvim,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        imports = [
          ./home/git.nix
          ./home/nixvim.nix
          ./home/hyprland.nix
          ./home/kitty.nix
          ./home/firefox.nix
          ./home/swaync.nix
          ./home/fuzzel.nix
          ./home/gtk.nix
          ./home/mangohud.nix
          nxvim.homeManagerModules.nixvim
        ];
        programs.home-manager.enable = true;
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
