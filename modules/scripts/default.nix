{ config, lib, ... }:
{
  options = {
    modules.scripts.enable = lib.mkEnableOption "enables scripts module";
  };
  imports = lib.mkIf config.modules.scripts.enable [
    ./bash.nix
  ];
}
