{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.overlays.bash-scripts.nixos-installer.enable {
    nixpkgs.overlays = [
      (self: super: {
        nixos-installer = pkgs.writeScriptBin "nixos-installer" ''
          #!/usr/bin/env bash
          ${builtins.readFile ../../../scripts/nixos-installer.sh}
        '';
      })
    ];
  };
}
