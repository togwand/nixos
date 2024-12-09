{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./formatters
  ];
  config = lib.mkIf config.apps.dev.treefmt.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      treefmt
    ];
  };
}
