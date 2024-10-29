{
  inputs = {
    nixpkgs-nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager-master = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-nixos-unstable";
    };
    nixvim-main = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs-nixos-unstable";
    };
  };

  outputs = {self, ...}: let
    nixpkgs-unstable = self.inputs.nixpkgs-nixos-unstable;
    home-unstable = self.inputs.home-manager-master;
    host-unstable = "nixos-unstable";
    user = "togwand";
    nixvim-unstable = self.inputs.nixvim-main;
  in {
    formatter.x86_64-linux = nixpkgs-unstable.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      "unstable" = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          home = home-unstable;
          host = host-unstable;
          inherit user;
          nixvim = nixvim-unstable;
        };
        modules = [./unstable/nixos.nix];
      };
    };
  };
}
