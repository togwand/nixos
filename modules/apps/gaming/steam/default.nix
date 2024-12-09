{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.apps.gaming.steam.enable {
    programs.steam.enable = true;
  };
}
