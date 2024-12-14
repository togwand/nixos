{ config, lib, ... }:
{
  config = lib.mkIf config.generic.nix.enable {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
    system.stateVersion = "25.05";
  };
}
