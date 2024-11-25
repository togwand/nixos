{ config, lib, ... }:
{
  options = { };
  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/eaf2c5ab-8651-4702-948b-9d463d381f85";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/A508-86F5";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    fileSystems."/mnt/windows" = {
      device = "/dev/disk/by-uuid/06C8132AC813178F";
      fsType = "ntfs3";
    };

    fileSystems."/mnt/games" = {
      device = "/dev/disk/by-uuid/D0BA1E03BA1DE72E";
      fsType = "ntfs3";
    };

    swapDevices = [
      {
        device = "/swapfile";
        size = 2 * 1024;
      }
    ];
  };
}
