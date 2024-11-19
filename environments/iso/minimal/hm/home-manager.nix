{
  pkgs,
  nxvim,
  ...
}: let
  installer-script = pkgs.writeShellApplication {
    name = "togwand-installer";
    text = "${builtins.readFile ../../../../scripts/bash/installer.bash}";
    runtimeInputs = with pkgs; [
      disko
    ];
  };
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "nixos" = {
        imports = [
          nxvim.homeManagerModules.nixvim
          ./zsh.nix
          ./ranger.nix
          ./nxvim/nixvim.nix
        ];
        programs = {
          home-manager.enable = true;
          git.enable = true;
          bat.enable = true;
        };
        home = {
          packages = with pkgs; [
            installer-script
          ];
          file = {};
          username = "nixos";
          homeDirectory = "/home/nixos";
          stateVersion = "24.11";
        };
      };
    };
  };
}
