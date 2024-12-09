{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.bat.enable {
    home-manager.users.${user}.programs.bat = lib.mkIf config.generic.home-manager.enable {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };
  };
}
