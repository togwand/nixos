{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
config = lib.mkIf config.derivations.tools.goris.enable import (pkgs.writeScriptBin "goris" "${builtins.readFile (inputs.tools + "/bash/goris.sh")}" {inherit pkgs;});}
