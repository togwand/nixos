{ config, lib, ... }:
{
  options = {
    modules.enable = lib.mkEnableOption "enables modules";
  };
  config = lib.mkIf config.modules.enable {
    imports = [
      ./home-manager
      ./scripts
    ];
  };
}
