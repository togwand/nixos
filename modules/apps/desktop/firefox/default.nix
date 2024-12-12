{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.firefox.enable {
    environment.variables = lib.mkIf config.generic.home-manager.enable {
      BROWSER = "firefox";
    };
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        bind = [ "$window-easy, w, exec, uwsm app -- firefox" ];
      };
      programs.firefox = {
        enable = true;
      };
    };
  };
}
