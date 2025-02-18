{ config, lib, ... }:
{
  imports = [
    ./desktop
    ./dev
    ./gaming
    ./tui
  ];

  options = {
    apps = {
      desktop = {
        enable = lib.mkEnableOption "";
        discord.enable = lib.mkEnableOption "";
        firefox.enable = lib.mkEnableOption "";
        foot.enable = lib.mkEnableOption "";
        gimp.enable = lib.mkEnableOption "";
        gtk.enable = lib.mkEnableOption "";
        hyprland.enable = lib.mkEnableOption "";
        inkscape.enable = lib.mkEnableOption "";
        krita.enable = lib.mkEnableOption "";
        qt.enable = lib.mkEnableOption "";
        swaync.enable = lib.mkEnableOption "";
        waybar.enable = lib.mkEnableOption "";
        wofi.enable = lib.mkEnableOption "";
      };
      dev = {
        enable = lib.mkEnableOption "";
        git.enable = lib.mkEnableOption "";
        nixvim.enable = lib.mkEnableOption "";
        texlive.enable = lib.mkEnableOption "";
        treefmt = {
          enable = lib.mkEnableOption "";
          beautysh.enable = lib.mkEnableOption "";
          nixfmt.enable = lib.mkEnableOption "";
        };
      };
      gaming = {
        enable = lib.mkEnableOption "";
        gamemode.enable = lib.mkEnableOption "";
        mangohud.enable = lib.mkEnableOption "";
        steam.enable = lib.mkEnableOption "";
      };
      tui = {
        enable = lib.mkEnableOption "";
        bash.enable = lib.mkEnableOption "";
        lf.enable = lib.mkEnableOption "";
        mpv.enable = lib.mkEnableOption "";
        rclone.enable = lib.mkEnableOption "";
        zsh.enable = lib.mkEnableOption "";
      };
    };
  };

  config = {
    apps = {
      desktop = lib.mkIf config.apps.desktop.enable {
        discord.enable = lib.mkDefault true;
        firefox.enable = lib.mkDefault true;
        foot.enable = lib.mkDefault true;
        gimp.enable = lib.mkDefault true;
        gtk.enable = lib.mkDefault true;
        hyprland.enable = lib.mkDefault true;
        inkscape.enable = lib.mkDefault true;
        krita.enable = lib.mkDefault true;
        qt.enable = lib.mkDefault true;
        swaync.enable = lib.mkDefault true;
        waybar.enable = lib.mkDefault true;
        wofi.enable = lib.mkDefault true;
      };
      dev = lib.mkIf config.apps.dev.enable {
        git.enable = lib.mkDefault true;
        nixvim.enable = lib.mkDefault true;
        texlive.enable = lib.mkDefault true;
        treefmt = {
          enable = lib.mkDefault true;
          beautysh.enable = lib.mkDefault config.apps.dev.treefmt.enable;
          nixfmt.enable = lib.mkDefault config.apps.dev.treefmt.enable;
        };
      };
      gaming = lib.mkIf config.apps.gaming.enable {
        gamemode.enable = lib.mkDefault true;
        mangohud.enable = lib.mkDefault true;
        steam.enable = lib.mkDefault true;
      };
      tui = lib.mkIf config.apps.tui.enable {
        bash.enable = lib.mkDefault true;
        lf.enable = lib.mkDefault true;
        mpv.enable = lib.mkDefault true;
        rclone.enable = lib.mkDefault true;
        zsh.enable = lib.mkDefault true;
      };
    };
  };
}
