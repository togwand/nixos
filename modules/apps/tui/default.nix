{ lib, ... }:
{
  imports = [
    ./bash
    ./bat
    ./ranger
    ./rclone
    ./zsh
  ];
  config = {
    apps.tui.enable = lib.mkDefault true;
  };
}
