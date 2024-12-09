{ config, lib, ... }:
{
  config = lib.mkIf config.generic.intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
