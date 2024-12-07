{ lib, ... }:
{
  imports = [
    ./bash
    ./bat
    ./ranger
    ./zsh
  ];
  config = {
    home-manager.tui.enable = lib.mkDefault true;
  };
}
