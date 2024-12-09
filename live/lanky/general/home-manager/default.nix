{
  pkgs,
  user,
  inputs,
  ...
}:
{
  home-manager.users.${user}.home = {
    file = { };
    packages = with pkgs; [
      inputs.goris.default
      disko
    ];
  };
}
