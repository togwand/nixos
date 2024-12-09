{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.firefox.enable {
    environment.variables = {
      BROWSER = "firefox";
    };
    home-manager.users.${user}.programs.firefox = {
      enable = true;
    };
  };
}
