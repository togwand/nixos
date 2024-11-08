{
  pkgs,
  config,
  user,
  host,
  hm,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./hm/home-manager.nix
    hm.nixosModules.home-manager
  ];

  hardware = {
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
      availableKernelModules = ["nvidia_drm"];
    };
    supportedFilesystems = ["ntfs"];
    loader = {
      timeout = 1;
      efi.canTouchEfiVariables = true;
      # systemd-boot.enable = true;
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
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
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
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      exfat
      ntfs3g
    ];
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
    # sessionVariables = {};
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
    sudo.extraConfig = ''
      Defaults timestamp_timeout=0
    '';
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
    config = {
      allowUnfree = true;
    };
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

  system.stateVersion = "24.05";
}
