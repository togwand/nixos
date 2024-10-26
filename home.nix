{ user-name, pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user-name} = {
        imports = [
          ./home/git.nix
          ./home/hyprland.nix
          ./home/kitty.nix
          # PICK AND CONFIGURE ANOTHER TERMINAL EMULATOR
          # PICK AND CONFIGURE ANOTHER SHELL
          ./home/neovim.nix
          ./home/swaync.nix
          ./home/fuzzel.nix
          ./home/mangohud.nix
        ];
        programs.home-manager.enable = true;
        home = {
          packages = with pkgs; [
            pavucontrol
            discord
            rclone
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
