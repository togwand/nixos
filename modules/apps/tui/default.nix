{ lib, ... }:
{
  imports = [
    ./bash
    ./ranger
    ./rclone
    ./zsh
  ];
  config = {
    apps.tui.enable = lib.mkDefault true;
  };
}
