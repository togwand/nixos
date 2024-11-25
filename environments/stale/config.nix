{
  config,
  host,
  lib,
  pkgs,
  user,
  ...
}:
{
  hardware = {
    # enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu = {
      intel.updateMicrocode = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

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
    fsType = "ntfs3";
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/D0BA1E03BA1DE72E";
    fsType = "ntfs3";
  };

  # fileSystems."/" = {
  #   device = "/dev/disk/by-uuid/eaf2c5ab-8651-4702-948b-9d463d381f85";
  #   fsType = "ext4";
  # };
  #
  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-uuid/A508-86F5";
  #   fsType = "vfat";
  #   options = [
  #     "fmask=0022"
  #     "dmask=0022"
  #   ];
  # };

  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024;
    }
  ];

  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    initrd = {
      verbose = false;
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
        "nvidia_drm"
      ];
    };
    kernelModules = [ "kvm-intel" ];
    supportedFilesystems = [
      "ntfs"
      "exfat"
    ];
    loader = {
      timeout = 2;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        timeoutStyle = "menu";
        default = "saved";
        device = "nodev";
        splashImage = null;
        configurationLimit = 15;
      };
    };
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = false;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      ${user} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        programs.home-manager.enable = true;
        home = {
          packages = with pkgs; [
            shell-manager
            wl-clipboard
            rclone
            pavucontrol
            discord
          ];
          file = { };
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = "24.11";
        };
      };
    };
  };

  console = {
    packages = with pkgs; [ uw-ttyp0 ];
    font = "t0-13b-uni";
    useXkbConfig = true;
    earlySetup = false;
  };

  services = {
    getty = {
      autologinUser = user;
      autologinOnce = false;
    };
    devmon.enable = true;
    xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "latam";
        options = "caps:swapescape";
      };
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  environment = {
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    zsh.enable = true;
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CommitMono" ]; })
      comfortaa
      gentium-book-basic
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    enableDefaultPackages = false;
    fontconfig = {
      enable = true;
      antialias = true;
      allowBitmaps = false;
      includeUserConf = true;
      defaultFonts = {
        monospace = [ "CommitMono Nerd Font Mono" ];
        sansSerif = [ "Comfortaa" ];
        serif = [ "Gentium Basic" ];
        emoji = [ "Noto Color Emoji" ];
      };
      hinting = {
        style = "full";
        enable = true;
        autohint = true;
      };
      subpixel = {
        rgba = "none";
        lcdfilter = "none";
      };
      useEmbeddedBitmaps = false;
      cache32Bit = false;
      allowType1 = false;
    };
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults timestamp_timeout=1";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time = {
    timeZone = "Chile/Continental";
    hardwareClockInLocalTime = true;
  };

  documentation = {
    enable = true;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
    nixos.enable = false;
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = false;
    };
  };

  system.stateVersion = "24.11";
}
