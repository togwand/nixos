{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.overlays.bash-scripts.shell-manager.enable {
    nixpkgs.overlays = [
      (self: super: {
        shell-manager = pkgs.writeScriptBin "shell-manager" ''
          #!/usr/bin/env bash
          ${builtins.readFile ../../../scripts/shell-manager.bash}
        '';
      })
    ];
  };
}
