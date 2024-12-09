{
  lib,
  pkgs,
  self,
  user,
  ...
}:
{
  hardware = {
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
    supportedFilesystems = [ "exfat" ];
    loader = {
      timeout = 4;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        timeoutStyle = "menu";
        default = "saved";
        device = "nodev";
        splashImage = "${self}/pictures/magic-sky.jpg";
        configurationLimit = 7;
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = false;
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  console = {
    packages = with pkgs; [ uw-ttyp0 ];
    font = "t0-13b-uni";
    earlySetup = false;
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

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
    settings.auto-optimise-store = false;
  };
}
