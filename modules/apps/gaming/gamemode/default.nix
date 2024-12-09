{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.apps.gaming.gamemode.enable {
    programs.gamemode.enable = true;
  };
}
