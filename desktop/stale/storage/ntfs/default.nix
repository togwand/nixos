{
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems = {
    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/06C8132AC813178F";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
      ];
    };
    "/mnt/games" = {
      device = "/dev/disk/by-uuid/D0BA1E03BA1DE72E";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
      ];
    };
  };
}
