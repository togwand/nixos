{ inputs, pkgs, ... }:
pkgs.writeScriptBin "goris" ''
  ${builtins.readFile (inputs.tools + "/bash/functions.sh")}
  ${builtins.readFile (inputs.tools + "/bash/goris.sh")}
''
