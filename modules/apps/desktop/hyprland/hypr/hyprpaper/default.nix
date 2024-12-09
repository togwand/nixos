{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.hyprland.enable {
    home-manager.users.${user}.services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [
          "~/collection/images/wallpapers/magic-sky.jpg"
        ];
        wallpaper = [
          ",~/collection/images/wallpapers/magic-sky.jpg"
        ];
      };
    };
  };
}
