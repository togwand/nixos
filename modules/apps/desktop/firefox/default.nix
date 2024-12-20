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
    xdg.mime = lib.mkIf config.generic.home-manager.enable {
      defaultApplications = {
        "video/mp4" = [ "firefox.desktop" ];
        "image/jpeg" = [ "firefox.desktop" ];
        "image/png" = [ "firefox.desktop" ];
        "audio/mpeg" = [ "firefox.desktop" ];
        "application/pdf" = [ "firefox.desktop" ];
        "application/msword" = [ "firefox.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "firefox.desktop" ];
      };
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
