{
  config,
  inputs,
  lib,
  pkgs,
  self,
  user,
  ...
}:
{
  derivations.tools.cadoras.enable = true;

  apps = {
    desktop.enable = true;
    dev.enable = true;
    gaming.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      (import "${self}/derivations/rice/zust-sddm" { inherit inputs pkgs; })
    ];
  };

  home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
    home.packages = with pkgs; [
      wl-clipboard
      pavucontrol
    ];
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
        theme = "zust";
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
