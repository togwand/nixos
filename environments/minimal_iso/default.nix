{
  inputs,
  user,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    inputs.home-manager.nixosModules.home-manager
    ./config.nix
  ];

  home-manager.users.${user}.imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
}
