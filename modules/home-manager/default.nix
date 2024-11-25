{ config, lib, ... }:
{
  options = {
    modules.home-manager.enable = lib.mkEnableOption "enables home-manager module";
  };
  imports = lib.mkIf config.modules.home-manager.enable [
    ./desktop
    ./dev
    ./gaming
    ./terminal
  ];
}
