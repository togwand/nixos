{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  options = { };
  config = {
    home-manager.users.${user}.gtk = {
      enable = true;
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
    };
  };
}
