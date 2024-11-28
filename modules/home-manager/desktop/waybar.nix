{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.waybar.enable {
    home-manager.users.${user}.programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 64;
          output = [
            "DP-1"
          ];
          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
            "wlr/taskbar"
          ];
          modules-center = [
            "hyrpland/window"
            "custom/hello-from-waybar"
          ];
          modules-right = [
            "temperature"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };
          "custom/hello-from-waybar" = {
            format = "hello {}";
            max-length = 40;
            interval = "once";
            exec = pkgs.writeShellScript "hello-from-waybar" ''
              echo "from within waybar"
            '';
          };
        };
      };
    };
  };
}
