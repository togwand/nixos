{ config, lib, ... }:
{
  options.intel.enable = lib.mkEnableOption "";
  config = lib.mkIf config.intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
