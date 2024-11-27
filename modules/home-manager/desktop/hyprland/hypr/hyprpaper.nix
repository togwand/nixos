{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.hyprland.hyprpaper.enable {
    home-manager.users.${user}.services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [
          "./magic-sky.jpg"
        ];
        wallpaper = [
          ",./magic-sky.jpg"
        ];
      };
    };
  };
}
