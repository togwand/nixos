{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.treefmt.mdsh.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      mdsh
    ];
  };
}
