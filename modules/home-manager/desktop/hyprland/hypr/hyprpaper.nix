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
        ipc = "off";
        splash = true;
        splash_offset = 5.0;

        preload = [
          "~/collection/images/wallpapers/chill-mountain.png"
        ];

        wallpaper = [
          ",~/collection/images/wallpapers/chill-mountain.png"
        ];
      };
    };
  };
}
