{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.wofi.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        bind = [
          "$window-easy, a, exec, uwsm app -- pkill wofi || uwsm app -- wofi --show drun"
        ];
      };
      programs.wofi = {
        enable = true;
        settings = {
          location = "center";
        };
        # style = { };
      };
    };
  };
}
