{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.rclone.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      rclone
    ];
  };
}
