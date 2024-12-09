{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.bat.enable {
    home-manager.users.${user}.programs.bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };
  };
}
