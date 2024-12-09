{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.treefmt.nixfmt.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      home.packages = with pkgs; [ nixfmt-rfc-style ];
    };
  };
}
