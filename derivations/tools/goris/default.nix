{ inputs, pkgs, ... }:
pkgs.writeScriptBin "goris" ''
  ${builtins.readFile (inputs.tools + "/bash/shared.sh")}
  ${builtins.readFile (inputs.tools + "/bash/goris.sh")}
''
