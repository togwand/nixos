{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}:
{
  options.derivations = {
    tools = {
      cadoras.enable = lib.mkEnableOption "";
      goris.enable = lib.mkEnableOption "";
    };
  };
  config = {
    environment.systemPackages = [
      (lib.mkIf config.derivations.tools.cadoras.enable (
        import "${self}/derivations/tools/cadoras" { inherit inputs pkgs; }
      ))
      (lib.mkIf config.derivations.tools.goris.enable (
        import "${self}/derivations/tools/goris" { inherit inputs pkgs; }
      ))
    ];
  };
}
