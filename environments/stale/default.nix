{ inputs, user, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./config.nix
    ./disko.nix
  ];

  home-manager.users.${user}.imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
}
