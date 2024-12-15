{
  inputs = {
    rice = {
      flake = false;
      url = "github:togwand/rice";
    };
    tools = {
      flake = false;
      url = "github:togwand/tools";
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
    {
      nixpkgs,
      self,
      ...
    }@inputs:
    let
      use =
        path: host: user:
        nixpkgs.lib.nixosSystem {
          modules = [
            path
            ./modules
          ];
          specialArgs = {
            inherit self inputs;
            host = host;
            user = user;
          };
        };
    in
    {
      nixosConfigurations = {
        stale = use ./desktop/stale "stale" "togwand";
        lanky = use ./live/lanky "lanky" "hacker";
      };
    };
}
