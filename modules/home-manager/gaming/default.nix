{ config, lib, ... }:
{
  options = {
    modules.home-manager.gaming.enable = lib.mkEnableOption "enables home-manager gaming programs";
  };
  imports = lib.mkIf config.modules.home-manager.gaming.enable [
    ./mangohud.nix
  ];
}
