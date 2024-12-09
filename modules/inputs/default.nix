{ inputs, user, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
  ];

  home-manager.users.${user}.imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
}
