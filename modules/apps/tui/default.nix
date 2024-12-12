{ lib, ... }:
{
  imports = [
    ./bash
    ./nnn
    ./rclone
    ./zsh
  ];
  config = {
    apps.tui.enable = lib.mkDefault true;
  };
}
