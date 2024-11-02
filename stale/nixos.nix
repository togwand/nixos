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
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      timeout = 0;
    };
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults timestamp_timeout=0
    '';
  };

  time.timeZone = "Chile/Continental";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
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
  };

  environment = {
    variables = {
      VISUAL = "nvim";
    };
    sessionVariables = {
      # NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["0xProto"];})
    ];
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        style = "medium";
        enable = true;
        autohint = false;
      };
      subpixel = {
        rgba = "none";
        lcdfilter = "light";
      };
      includeUserConf = true;
      cache32Bit = false;
      allowType1 = false;
      allowBitmaps = false;
      useEmbeddedBitmaps = false;
      defaultFonts = {
        serif = ["DejaVu Serif"];
        sansSerif = ["TeX Gyre Adventor"];
        monospace = ["0xProto Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
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
