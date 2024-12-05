{
  disko.devices.disk.main = {
    device = "/dev/disk/by-id/ata-CT120BX500SSD1_1949E3DC2F9B";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          name = "esp";
          size = "550M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          name = "root";
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/06C8132AC813178F";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/D0BA1E03BA1DE72E";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024;
    }
  ];
}
