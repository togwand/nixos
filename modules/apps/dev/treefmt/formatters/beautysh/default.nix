{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.treefmt.beautysh.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      beautysh
    ];
  };
}
