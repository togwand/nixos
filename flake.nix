{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wandpkgs = {
      url = "github:togwand/wandpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs =
    {
      nixpkgs,
      wandpkgs,
      self,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        "stale" = nixpkgs.lib.nixosSystem {
          modules = [
            ./desktop/stale
            ./modules
          ];
          specialArgs = {
            inherit wandpkgs self inputs;
            user = "togwand";
            host = "stale";
          };
        };
        "lanky" = nixpkgs.lib.nixosSystem {
          modules = [
            ./live/lanky
            ./modules
          ];
          specialArgs = {
            inherit wandpkgs self inputs;
            user = "hacker";
            host = "lanky";
          };
        };
      };
    };
}
