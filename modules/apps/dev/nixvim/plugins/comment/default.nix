{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user}.programs.nixvim.plugins.comment =
      lib.mkIf config.generic.home-manager.enable
        {
          enable = true;
        };
  };
}
