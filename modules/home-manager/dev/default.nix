{ config, lib, ... }:
{
  options = {
    modules.home-manager.dev.enable = lib.mkEnableOption "enables home-manager dev programs";
  };
  imports = lib.mkIf config.modules.home-manager.dev.enable [
    ./nixvim
    ./git.nix
  ];
}
