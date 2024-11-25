{ pkgs, user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        programs.home-manager.enable = true;
        home = {
          packages = with pkgs; [
            shell-manager
            wl-clipboard
            rclone
            pavucontrol
            discord
          ];
          file = { };
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = "24.11";
        };
      };
    };
  };
}
