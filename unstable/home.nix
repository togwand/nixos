{
  user,
  pkgs,
  nixvim,
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
          ./home/mangohud.nix
          ./home/gtk.nix
          nixvim.homeManagerModules.nixvim
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
