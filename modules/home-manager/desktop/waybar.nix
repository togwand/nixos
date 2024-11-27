{
  config,
  lib,
  user,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.waybar.enable {
    home-manager.users.${user}.programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];
          position = "top";
          height = 30;
          width = 30;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
            "wlr/taskbar"
          ];
          modules-center = [
            "sway/window"
            "custom/hello-from-waybar"
          ];
          modules-right = [
            "mpd"
            "custom/mymodule#with-css-id"
            "temperature"
          ];
          spacing = 4;
          "hyprland/workspaces" = {
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
