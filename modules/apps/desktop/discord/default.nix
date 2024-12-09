{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.discord.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      discord
    ];
  };
}
