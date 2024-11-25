{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.dev.nixvim.comment.enable {
    home-manager.users.${user}.programs.nixvim.plugins.comment = {
      enable = true;
    };
  };
}
