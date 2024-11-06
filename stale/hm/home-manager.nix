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
          ./dev/git.nix
          ./dev/nxvim/nixvim.nix
          ./desktop/hyprland.nix
          ./desktop/swaync.nix
          ./desktop/fuzzel.nix
          ./desktop/gtk.nix
          ./terminal/foot.nix
          ./terminal/ranger.nix
          ./web-browsers/firefox.nix
          ./gaming/mangohud.nix
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
