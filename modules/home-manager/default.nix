{ config, lib, ... }:
{
  imports = [
    ./desktop
    ./dev
    ./gaming
    ./tui
  ];

  options = {
    home-manager = {
      desktop = {
        enable = lib.mkEnableOption "";
        firefox.enable = lib.mkEnableOption "";
        foot.enable = lib.mkEnableOption "";
        gtk.enable = lib.mkEnableOption "";
        hyprland.enable = lib.mkEnableOption "";
        hyprpaper.enable = lib.mkEnableOption "";
        swaync.enable = lib.mkEnableOption "";
        tofi.enable = lib.mkEnableOption "";
        waybar.enable = lib.mkEnableOption "";
      };
      dev = {
        enable = lib.mkEnableOption "";
        git.enable = lib.mkEnableOption "";
        nixvim.enable = lib.mkEnableOption "";
      };
      gaming = {
        enable = lib.mkEnableOption "";
        mangohud.enable = lib.mkEnableOption "";
      };
      tui = {
        enable = lib.mkEnableOption "";
        bash.enable = lib.mkEnableOption "";
        bat.enable = lib.mkEnableOption "";
        ranger.enable = lib.mkEnableOption "";
        zsh.enable = lib.mkEnableOption "";
      };
    };
  };

  config = {
    home-manager = {
      desktop = lib.mkIf config.home-manager.desktop.enable {
        firefox.enable = lib.mkDefault true;
        foot.enable = lib.mkDefault true;
        gtk.enable = lib.mkDefault true;
        hyprland.enable = lib.mkDefault true;
        hyprpaper.enable = lib.mkDefault true;
        swaync.enable = lib.mkDefault true;
        tofi.enable = lib.mkDefault true;
        waybar.enable = lib.mkDefault true;
      };
      dev = lib.mkIf config.home-manager.dev.enable {
        git.enable = lib.mkDefault true;
        nixvim.enable = lib.mkDefault true;
      };
      gaming = lib.mkIf config.home-manager.gaming.enable {
        mangohud.enable = lib.mkDefault true;
      };
      tui = lib.mkIf config.home-manager.tui.enable {
        bash.enable = lib.mkDefault true;
        bat.enable = lib.mkDefault true;
        ranger.enable = lib.mkDefault true;
        zsh.enable = lib.mkDefault true;
      };
    };
  };
}
