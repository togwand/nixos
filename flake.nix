{
  inputs = {
    nixpkgs-nixos-uakari.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager-release-uakari = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-nixos-uakari";
    };
    home-manager-master = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-nixos-unstable";
    };
  };

  outputs = {self, ...}: let
    uakari-nixpkgs = self.inputs.nixpkgs-nixos-uakari;
    uakari-home = self.inputs.home-manager-release-uakari;
    uakari-host = "nixos-uakari";
    unstable-nixpkgs = self.inputs.nixpkgs-nixos-unstable;
    unstable-home = self.inputs.home-manager-master;
    unstable-host = "nixos-unstable";
    user = "togwand";
  in {
    formatter.x86_64-linux = unstable-nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      "uakari" = uakari-nixpkgs.lib.nixosSystem {
        specialArgs = {
          home = uakari-home;
          host = uakari-host;
          inherit user;
        };
        modules = [./uakari/nixos.nix];
      };
      "unstable" = unstable-nixpkgs.lib.nixosSystem {
        specialArgs = {
          home = unstable-home;
          host = unstable-host;
          inherit user;
        };
        modules = [./unstable/nixos.nix];
      };
    };
  };
}
