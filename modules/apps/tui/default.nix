{ lib, ... }:
{
  imports = [
    ./bash
    ./lf
    ./mpv
    ./rclone
    ./zsh
  ];
  config = {
    apps.tui.enable = lib.mkDefault true;
  };
}
