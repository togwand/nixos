{ user-name, pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user-name} = {
        imports = [
          ./home/git.nix
          ./home/neovim.nix
          ./home/hyprland.nix
          # PICK AND CONFIGURE ANOTHER TERMINAL EMULATOR
          # PICK AND CONFIGURE ANOTHER SHELL
          ./home/swaync.nix
          ./home/fuzzel.nix
          ./home/mangohud.nix
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
            xdg-utils
          ];
          file = { };
          username = user-name;
          homeDirectory = "/home/${user-name}";
          stateVersion = "24.05";
        };
      };
    };
  };
}
