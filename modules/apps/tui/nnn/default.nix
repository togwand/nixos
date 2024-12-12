{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.nnn.enable {
    home-manager.users.${user} = {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        bind = lib.mkIf config.apps.desktop.foot.enable [
          "$window-easy, n, exec, uwsm app -- foot -e nnn -edioUT e"
        ];
      };
      programs.nnn = lib.mkIf config.generic.home-manager.enable {
        enable = true;
        package = pkgs.nnn.override { withEmojis = true; };
        extraPackages = with pkgs; [
          ffmpegthumbnailer
          mediainfo
          sxiv
        ];
      };
    };
  };
}
