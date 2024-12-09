{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.treefmt.beautysh.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      home.packages = with pkgs; [ beautysh ];
    };
  };
}
