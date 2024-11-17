{
  pkgs,
  nxvim,
  user,
  ...
}: let
  manager = pkgs.writeShellApplication {
    name = "togwand-manager";
    text = "${builtins.readFile ../../../../scripts/bash/manager.bash}";
    # runtimeInputs = with pkgs; [
    # ];
  };
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        imports = [
          nxvim.homeManagerModules.nixvim
          ./dev/git.nix
          ./dev/nxvim/nixvim.nix
          ./desktop/hyprland.nix
          ./desktop/swaync.nix
          ./desktop/fuzzel.nix
          ./desktop/gtk.nix
          ./terminal/bash.nix
          ./terminal/zsh.nix
          ./terminal/foot.nix
          ./terminal/ranger.nix
          ./terminal/bat.nix
          ./web-browsers/firefox.nix
          ./gaming/mangohud.nix
        ];
        programs.home-manager.enable = true;
        home = {
          packages = with pkgs; [
            manager
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
