{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.generic.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${user} = {
        programs.home-manager.enable = true;
        home = {
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = config.system.stateVersion;
        };
      };
    };
  };
}
