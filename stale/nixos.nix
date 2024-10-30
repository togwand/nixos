{
  pkgs,
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
      open = true;
      modesetting.enable = true;
      nvidiaSettings = false;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  boot = {
  	tmp.cleanOnBoot = true;
  	loader = {
		systemd-boot.enable = true;
		timeout = 0;
	};
    plymouth = {
      enable = true;
	  theme = "breeze";
    };
    consoleLogLevel = 0;
    initrd = {
		systemd.enable = true;
		verbose = false;
	};
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
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
    greetd = {
      enable = true;
      restart = false;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "${user}";
        };
        default_session = initial_session;
      };
    };
    xserver = {
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
	enableGhostscriptFonts = false;
    fontDir = {
      enable = false;
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
        lcdfilter = "none";
      };
      hinting = {
        style = "none";
        enable = false;
        autohint = false;
      };
      includeUserConf = true;
      useEmbeddedBitmaps = false;
      defaultFonts = {
	  	serif = ["0xProto Nerd Font Propo"];
		sansSerif = ["DejaVu Sans"];
		monospace = ["0xProto Nerd Font Mono"];
		emoji = ["0xProto Nerd Font Propo"];
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
