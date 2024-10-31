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

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      #  grub = {
      #  	enable = true;
      # device = "nodev";
      # default = "saved";
      # timeoutStyle = "hidden"; # Test this setting for no-flickering boot
      #  };
      timeout = 0;
    };
    plymouth = {
      enable = true;
      theme = "abstract_ring";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {selected_themes = ["abstract_ring"];})
      ];
    };
    initrd = {
      # systemd.enable = true; # Test if this changes anything about boot flickering
      kernelModules = [
        "nvidia_drm"
      ];
      verbose = false;
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=0"
    ];
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults timestamp_timeout=0
    '';
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = false;
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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  console.useXkbConfig = true;
  time.timeZone = "Chile/Continental";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    displayManager = {
      enable = true;
      defaultSession = "hyprland";
      autoLogin = {
        enable = false;
        user = user;
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
      };
    };
    xserver = {
      enable = false;
      xkb.layout = "latam";
      videoDrivers = ["nvidia"];
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
	systemPackages = with pkgs ; [
		sddm-astronaut
	];
  };

  qt.enable = true;

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
    enableGhostscriptFonts = false;
    fontDir = {
      enable = true;
      decompressFonts = false;
    };
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = false;
      allowType1 = false;
      allowBitmaps = false;
      subpixel = {
        rgba = "none";
        lcdfilter = "light";
      };
      hinting = {
        style = "medium";
        enable = true;
        autohint = false;
      };
      includeUserConf = true;
      useEmbeddedBitmaps = false;
      defaultFonts = {
        serif = ["DejaVu Serif"];
        sansSerif = ["TeX Gyre Adventor"];
        monospace = ["0xProto Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
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
  system.stateVersion = "24.05";
}
