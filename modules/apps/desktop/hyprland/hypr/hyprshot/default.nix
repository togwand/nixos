{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.hyprland.enable {
    environment.variables = {
      HYPRSHOT_DIR = "collection/images/hyprshot";
    };
    home-manager.users.${user}.home.packages = with pkgs; [
      hyprshot
    ];
  };
}
