{
  inputs = {
    nixpkgs-uakari.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager-uakari = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-uakari";
    };
  };

  outputs =
    { self, ... }:
    let
      current-nixpkgs = self.inputs.nixpkgs-uakari;
      current-home = self.inputs.home-manager-uakari;
      host-name = "stale";
      user-name = "togwand";
    in
    {
      formatter.x86_64-linux = current-nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations = {
        ${host-name} = current-nixpkgs.lib.nixosSystem {
          specialArgs = {
            home = current-home;
            inherit host-name user-name;
          };
          modules = [ ./nixos.nix ];
        };
      };
    };
}
