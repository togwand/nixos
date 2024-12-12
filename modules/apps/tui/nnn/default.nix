{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.nnn.enable {
    home-manager.users.${user}.programs.nnn = lib.mkIf config.generic.home-manager.enable {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        bind = [ "$window-easy, n, exec, uwsm app -- $TERM -e nnn -edioUT e" ];
      };
      enable = true;
      extraPackages = with pkgs; [
        ffmpegthumbnailer
        mediainfo
        sxiv
      ];
      package = pkgs.nnn.override { withEmojis = true; };
    };
  };
}
