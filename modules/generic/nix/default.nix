{ config, lib, ... }:
{
  config = lib.mkIf config.generic.linux.enable {

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];

    system.stateVersion = "25.05";
  };
}
