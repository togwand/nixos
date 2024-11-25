{
  config,
  lib,
  user,
  ...
}:
{
  options = { };
  config = {
    home-manager.users.${user}.programs.firefox = {
      enable = true;
    };
  };
}
