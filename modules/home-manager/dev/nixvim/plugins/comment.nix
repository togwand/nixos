{
  config,
  lib,
  user,
  ...
}:
{
  options = { };
  config = {
    home-manager.users.${user}.programs.nixvim.plugins.comment = {
      enable = true;
    };
  };
}
