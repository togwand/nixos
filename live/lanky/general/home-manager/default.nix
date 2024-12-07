{
  pkgs,
  user,
  inputs,
  ...
}:
{
  home-manager = {
    dev.enable = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        programs.home-manager.enable = true;
        home = {
          packages = with pkgs; [
            inputs.goris.default
            disko
          ];
          file = { };
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = "25.05";
        };
      };
    };
  };
}
