{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.mpv.enable {
    environment.variables = lib.mkIf config.generic.home-manager.enable {
      MEDIA = "mpv";
    };
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.mpv.enable = true;
    };
  };
}
