{
  pkgs,
  home,
  host-name,
  user-name,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./home.nix
    home.nixosModules.home-manager
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      warnUndeclaredOptions = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
    };
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = true;
    };
  };

  programs = {
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  services = {
    blueman.enable = true;
    xserver = {
      enable = false;
      xkb.layout = "latam";
      videoDrivers = [ "nvidia" ];
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
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
    hostName = host-name;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  console.useXkbConfig = true;
  time.timeZone = "Chile/Continental";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    packages = with pkgs; [
      gyre-fonts
      (nerdfonts.override { fonts = [ "0xProto" ]; })
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = false;
        style = "full";
      };
      defaultFonts = {
        serif = [ "TeXGyrePagella" ];
        sansSerif = [ "TeXGyreAdventor" ];
        monospace = [ "0xProto Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  users.users = {
    # Remember to set a "#passwd" for all users
    ${user-name} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  system.stateVersion = "24.05";
}
