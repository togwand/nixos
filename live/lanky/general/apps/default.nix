{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  derivations.tools.goris.enable = true;

  apps = {
    dev = {
      enable = true;
      treefmt.enable = false;
    };
    tui.rclone.enable = false;
    tui.mpv.enable = false;
  };

  environment.systemPackages = with pkgs; [
    disko
  ];

  home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
    # home.packages = with pkgs; [ ];
  };

  services = {
    xserver.xkb.layout = "latam";
    getty = {
      greetingLine = "Lanky NixOS configuration is now ready";
      helpLine = lib.mkForce ''
        Install NixOS with goris
      '';
    };
  };
}
