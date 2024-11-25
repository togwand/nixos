{ config, lib, ... }:
{
  options = {
    modules.home-manager.desktop.enable = lib.mkEnableOption "enables home-manager desktop programs";
  };
  imports = lib.mkIf config.modules.home-manager.desktop.enable [
    ./firefox.nix
    ./fuzzel.nix
    ./gtk.nix
    ./hyprland.nix
    ./swaync.nix
  ];
}
