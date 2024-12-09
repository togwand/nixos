{ lib, ... }:
{
  imports = [
    ./home-manager
    ./intel
    ./linux
    ./nix
    ./nvidia
  ];

  options = {
    generic = {
      home-manager.enable = lib.mkEnableOption "";
      intel.enable = lib.mkEnableOption "";
      linux.enable = lib.mkEnableOption "";
      nix.enable = lib.mkEnableOption "";
      nvidia.enable = lib.mkEnableOption "";
    };
  };
}
