{
  inputs = {
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
      arch = "x86_64-linux";
    in
    {
      formatter.${arch} = nixpkgs.legacyPackages.${arch}.nixfmt-rfc-style;
      nixosConfigurations."minimal_iso" = nixpkgs.lib.nixosSystem {
        modules = [
          ./environments/minimal_iso
          ./modules
        ];
        specialArgs = {
          inherit inputs;
          user = "nixos";
        };
      };
      nixosConfigurations."stale" = nixpkgs.lib.nixosSystem {
        modules = [
          ./environments/stale
          ./modules
        ];
        specialArgs = {
          inherit inputs;
          user = "togwand";
          host = "stale";
        };
      };
    };
}
