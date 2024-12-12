{ lib, ... }:
{
  imports = [
    ./bash
    ./lf
    ./ranger
    ./rclone
    ./zsh
  ];
  config = {
    apps.tui.enable = lib.mkDefault true;
  };
}
