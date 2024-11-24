{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      # Bash
      shell-manager = pkgs.writeScriptBin "shell-manager" ''
        #!/usr/bin/env bash
        ${builtins.readFile ../shell-manager.bash}
      '';
      nixos-installer = pkgs.writeScriptBin "nixos-installer" ''
        #!/usr/bin/env bash
        ${builtins.readFile ../nixos-installer.bash}
      '';
    })
  ];
}
