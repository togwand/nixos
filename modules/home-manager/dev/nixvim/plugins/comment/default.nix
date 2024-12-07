{
  user,
  ...
}:
{
  config = {
    home-manager.users.${user}.programs.nixvim.plugins.comment = {
      enable = true;
    };
  };
}
