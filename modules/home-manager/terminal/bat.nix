{
  config,
  lib,
  user,
  ...
}:
{
  options = { };
  config = {
    home-manager.users.${user}.programs.bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };
  };
}
