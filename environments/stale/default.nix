{ inputs, user, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    ./config.nix
    ./devices.nix
    ./home.nix
    ./modules.nix
  ];

  home-manager.users.${user}.imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
}
