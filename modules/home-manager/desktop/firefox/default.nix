{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.home-manager.desktop.firefox.enable {
    home-manager.users.${user}.programs.firefox = {
      enable = true;
    };
  };
}
