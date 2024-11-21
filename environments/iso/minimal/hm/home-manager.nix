{
  pkgs,
  nxvim,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "nixos" = {
        imports = [
          nxvim.homeManagerModules.nixvim
          ./nxvim/nixvim.nix
          ./zsh.nix
          ./ranger.nix
        ];
        programs = {
          home-manager.enable = true;
          git.enable = true;
          bat.enable = true;
        };
        home = {
          packages = with pkgs; [
            nixos-installer
            disko
          ];
          username = "nixos";
          homeDirectory = "/home/nixos";
          stateVersion = "24.11";
        };
      };
    };
  };
}
