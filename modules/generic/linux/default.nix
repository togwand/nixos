{
  config,
  lib,
  host,
  ...
}:
{
  config = lib.mkIf config.generic.linux.enable {

    hardware.enableRedistributableFirmware = true;
    boot = {
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
      ];
    };

    networking.hostName = host;

    console.useXkbConfig = true;
    services.xserver.xkb.options = "caps:swapescape";

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
