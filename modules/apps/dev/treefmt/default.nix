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
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      home.packages = with pkgs; [ treefmt ];
    };
  };
}
