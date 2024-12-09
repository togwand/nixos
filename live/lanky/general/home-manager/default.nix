{ user, ... }:
{
  home-manager.users.${user}.home = {
    file = { };
  };
}
