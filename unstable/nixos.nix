{
  pkgs,
  home,
  host,
  user,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./home.nix
    home.nixosModules.home-manager
  ];

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

  programs = {
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;
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

  services = {
    xserver = {
      xkb.layout = "latam";
      videoDrivers = ["nvidia"];
    };
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
    blueman.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;

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
      powerOnBoot = false;
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  console.useXkbConfig = true;
  time.timeZone = "Chile/Continental";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    packages = with pkgs; [
      gyre-fonts
      (nerdfonts.override {fonts = ["0xProto"];})
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = false;
        style = "full";
      };
      defaultFonts = {
        serif = ["TeXGyrePagella"];
        sansSerif = ["TeXGyreAdventor"];
        monospace = ["0xProto Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  users.users = {
    # Remember to set a "#passwd" for all users
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
