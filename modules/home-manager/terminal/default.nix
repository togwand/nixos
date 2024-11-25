{ config, lib, ... }:
{
  options = {
    modules.home-manager.terminal.enable = lib.mkEnableOption "enables home-manager terminal programs";
  };
  imports = lib.mkIf config.modules.home-manager.terminal.enable [
    ./bash.nix
    ./bat.nix
    ./foot.nix
    ./ranger.nix
    ./zsh.nix
  ];
}
