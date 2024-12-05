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
    enableRedistributableFirmware = true;
    cpu = {
      intel.updateMicrocode = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    display = {
      edid = {
        enable = true;
        modelines = {
          "FHD_75" = "     167.85   1920 1928 1960 2000   1080 1105 1113 1119   +hsync -vsync";
          "FHD_90" = "     202.86   1920 1928 1960 2000   1080 1113 1121 1127   +hsync -vsync";
          "FHD_105" = "    238.35   1920 1928 1960 2000   1080 1121 1129 1135   +hsync -vsync";
          "FHD_120" = "    274.56   1920 1928 1960 2000   1080 1130 1138 1144   +hsync -vsync";
          "FHD_144" = "    333.216  1920 1928 1960 2000   1080 1143 1151 1157   +hsync -vsync";
        };
      };
      outputs = {
        "DP-1" = {
          edid = "FHD_144.bin";
          mode = "";
        };
      };
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
            hyprshot
            hyprpicker
            discord
          ];
          file = { };
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = "25.05";
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
    displayManager = {
      enable = true;
      defaultSession = "hyprland-uwsm";
      autoLogin = {
        enable = true;
        user = user;
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sugar-dark";
      };
    };
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
    devmon.enable = true;
  };

  environment = {
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
      TERMINAL = "foot";
      HYPRSHOT_DIR = "collection/images/hyprshot";
      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
    };
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      sddm-sugar-dark
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      systemd.setPath.enable = true;
    };
    steam.enable = true;
    gamemode.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.commit-mono
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

  system.stateVersion = "25.05";
}
