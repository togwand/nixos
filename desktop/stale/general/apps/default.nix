{
  config,
  lib,
  pkgs,
  user,
  wandpkgs,
  ...
}:
{
  apps = {
    desktop.enable = true;
    dev.enable = true;
    gaming.enable = true;
  };

  home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
    home.packages = with pkgs; [
      wl-clipboard
      pavucontrol
    ];
  };

  environment.systemPackages =
    with pkgs;
    with wandpkgs;
    [
      cadoras
      sddm-sugar-dark
      libsForQt5.qt5.qtgraphicaleffects
    ];

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
      xkb.layout = "latam";
    };
    devmon.enable = true;
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
}
