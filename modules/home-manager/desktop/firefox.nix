{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.firefox.enable {
    home-manager.users.${user}.programs.firefox = {
      enable = true;
    };
  };
}
