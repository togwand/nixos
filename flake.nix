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
    user = "togwand";
    host = "stale";
    sys = "x86_64-linux";
  in {
    formatter.${sys} = npkgs.legacyPackages.${sys}.alejandra;
    nixosConfigurations.${host} = npkgs.lib.nixosSystem {
      specialArgs = {inherit user host hm nxvim;};
      modules = [./unstable/nixos.nix];
    };
  };
}
