{
  pkgs,
  nxvim,
  ...
}: {
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
            disko
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
