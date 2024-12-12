{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.lf.enable {
    home-manager.users.${user}.programs.lf = lib.mkIf config.generic.home-manager.enable {
      enable = true;
      settings = {
      };
    };
  };
}
