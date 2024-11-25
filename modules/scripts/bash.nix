{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      shell-manager = pkgs.writeScriptBin "shell-manager" ''
        #!/usr/bin/env bash
        ${builtins.readFile ../../scripts/shell-manager.bash}
      '';
      nixos-installer = pkgs.writeScriptBin "nixos-installer" ''
        #!/usr/bin/env bash
        ${builtins.readFile ../../scripts/nixos-installer.bash}
      '';
    })
  ];
}
