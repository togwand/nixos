{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
config = lib.mkIf config.derivations.tools.cadoras.enable import (pkgs.writeScriptBin "cadoras" "${builtins.readFile (inputs.tools + "/bash/cadoras.sh")}" {inherit pkgs;});}
