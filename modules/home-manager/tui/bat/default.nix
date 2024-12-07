{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.home-manager.tui.bat.enable {
    home-manager.users.${user}.programs.bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };
  };
}
