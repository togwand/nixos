{ modulesPath,... }:
{
  inputs = {
	disko = {
		url = "github:nix-community/disko/master";
		inputs.nixpkgs.follows = "nixpkgs";
	};
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "hm";
    };
  };
  outputs =
    {
	  disko,
      home-manager,
      nixpkgs,
      nixvim,
      ...
    }: {
      formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixfmt-rfc-style;
      nixosConfigurations."minimal_iso" = nixpkgs.lib.nixosSystem {
        modules = [ 
		./environments/minimal_iso.nix
		"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
		home-manager.nixosModules.home-manager
		nixvim.homeManagerModules.nixvim
		];
      };
      nixosConfigurations."stale" = nixpkgs.lib.nixosSystem {
        modules = [ 
		./environments/stale.nix 
		home-manager.nixosModules.home-manager
		nixvim.homeManagerModules.nixvim
		];
      };
    };
}
