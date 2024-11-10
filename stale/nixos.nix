{
  config,
  pkgs,
  user,
  host,
  hm,
  ...
}: {
  hardware = {
    cpu.intel.updateMicrocode = true;
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

  fileSystems."nixos-boot" = {
    mountPoint = "/boot";
    device = "/dev/disk/by-uuid/05C4-521F";
    fsType = "auto";
    neededForBoot = true;
    # options = ["umask=022"];
  };

  fileSystems."nixos-root" = {
    mountPoint = "/";
    device = "/dev/disk/by-uuid/271815b6-fce2-4a33-be9d-a347bb5b12cf";
    fsType = "auto";
    neededForBoot = true;
    # options = ["defaults"];
  };

  fileSystems."windows" = {
    mountPoint = "/mnt/windows";
    device = "/dev/disk/by-uuid/90F28A4FF28A398C";
    fsType = "auto";
    neededForBoot = false;
    # options = ["rw" "uid=1000"];
  };

  fileSystems."games" = {
    mountPoint = "/mnt/games";
    device = "/dev/disk/by-uuid/2A4283244282F3BB";
    fsType = "auto";
    neededForBoot = false;
    # options = ["rw" "uid=1000"];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024;
    }
  ];

  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 3;
    kernelParams = ["quiet" "udev.log_level=3"];
    kernelModules = ["kvm-intel"];
    initrd = {
      verbose = false;
      availableKernelModules = [
        "nvidia_drm"
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
      ];
    };
    supportedFilesystems = ["ntfs"];
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
    firewall.enable = false;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      ${user} = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
      };
    };
  };

  console = {
    packages = with pkgs; [uw-ttyp0];
    font = "t0-13b-uni";
    useXkbConfig = true;
    earlySetup = false;
  };

  services = {
    getty = {
      autologinUser = user;
      autologinOnce = false;
    };
    # gvfs.enable = true;
    # devmon.enable = true;
    # udisks2.enable = true;
    xserver = {
      enable = false;
      videoDrivers = ["nvidia"];
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
    # systemPackages = with pkgs; [exfat ntfs3];
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
    pathsToLink = ["/share/zsh"];
  };

  programs = {
    zsh.enable = true;
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["CommitMono"];})
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
        monospace = ["CommitMono Nerd Font Mono"];
        sansSerif = ["Comfortaa"];
        serif = ["Gentium Basic"];
        emoji = ["Noto Color Emoji"];
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
    sudo.extraConfig = "Defaults timestamp_timeout=0";
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
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
    settings = {
      experimental-features = ["flakes" "nix-command"];
      auto-optimise-store = false;
    };
  };

  imports = [
    hm.nixosModules.home-manager
    ./hm/home-manager.nix
  ];

  system.stateVersion = "24.05";
}
