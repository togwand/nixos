{
  inputs = {
    npkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hm = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "npkgs";
    };
    nxvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "npkgs";
      inputs.home-manager.follows = "hm";
    };
  };
  outputs = {
    npkgs,
    hm,
    nxvim,
    ...
  }: let
    sys = "x86_64-linux";
  in {
    formatter.${sys} = npkgs.legacyPackages.${sys}.alejandra;
    nixosConfigurations."stale" = npkgs.lib.nixosSystem {
      modules = [./environments/desktop/stale/nixos.nix];
      specialArgs = {
        inherit hm nxvim;
        user = "togwand";
        host = "stale";
      };
    };
    nixosConfigurations."minimal" = npkgs.lib.nixosSystem {
      modules = [./environments/iso/minimal/nixos.nix];
      specialArgs = {
        inherit hm nxvim;
      };
    };
  };
}
