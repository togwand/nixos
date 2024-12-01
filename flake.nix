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
    { nixpkgs, systems, ... }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (
        pkgs: inputs.nixvim.inputs.treefmt-nix.lib.evalModule pkgs ./modules/treefmt-nix
      );
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
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
