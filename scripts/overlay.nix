{pkgs, ...}: {
  nixpkgs.overlays = [
    (self: super: {
      shell-manager = pkgs.writeScriptBin "shell-manager" ''
        #!/usr/bin/env bash
        ${builtins.readFile ./bash/shell-manager.bash}
      '';
      nixos-installer = pkgs.writeScriptBin "nixos-installer" ''
        #!/usr/bin/env bash
        ${builtins.readFile ./bash/nixos-installer.bash}
      '';
    })
  ];
}
