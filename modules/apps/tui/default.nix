{ lib, ... }:
{
  imports = [
    ./bash
    ./lf
    ./rclone
    ./zsh
  ];
  config = {
    apps.tui.enable = lib.mkDefault true;
  };
}
