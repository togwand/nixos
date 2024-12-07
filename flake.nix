{
  description = "flake for togwand/nixos";
  inputs = {
    cadoras = {
      url = "github:togwand/cadoras";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    goris = {
      url = "github:togwand/goris";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    { nixpkgs, ... }@inputs:
    let
    in
    {
      nixosConfigurations = {
        "stale" = nixpkgs.lib.nixosSystem {
          modules = [
            ./desktop/stale
            ./modules
          ];
          specialArgs = {
            inherit inputs;
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
            inherit inputs;
            user = "nixos";
            host = "lanky";
          };
        };
      };
    };
}
