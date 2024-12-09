{
  imports = [
    ./apps
    ./home-manager
    ./system
  ];
  config = {
    generic.home-manager.enable = true;
    generic.linux.enable = true;
    generic.nix.enable = true;
  };
}
