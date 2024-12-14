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
    dev = {
      enable = true;
      treefmt.enable = false;
    };
    tui.rclone.enable = false;
  };

  home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
    # home.packages = with pkgs; [ ];
  };

  environment.systemPackages =
    with pkgs;
    with wandpkgs;
    [
      goris
      disko
    ];

  services = {
    xserver.xkb.layout = "latam";
    getty = {
      greetingLine = "Lanky NixOS configuration is now ready";
      helpLine = lib.mkForce ''
        Install an OS with goris
      '';
    };
  };
}
