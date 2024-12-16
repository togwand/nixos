{ inputs, pkgs, ... }:
pkgs.writeScriptBin "cadoras" ''
  ${builtins.readFile (inputs.tools + "/bash/functions.sh")}
  ${builtins.readFile (inputs.tools + "/bash/cadoras.sh")}
''
