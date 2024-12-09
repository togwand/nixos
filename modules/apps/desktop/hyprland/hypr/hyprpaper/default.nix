{
  config,
  lib,
  self,
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
          "${self}/pictures/magic-sky.jpg"
        ];
        wallpaper = [
          ", ${self}/pictures/magic-sky.jpg"
        ];
      };
    };
  };
}
