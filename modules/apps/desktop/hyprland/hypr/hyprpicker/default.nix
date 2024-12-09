{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.hyprland.enable {
    home-manager.users.${user}.home.packages = with pkgs; [
      hyprpicker
    ];
  };
}
