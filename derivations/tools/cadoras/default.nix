{ inputs, pkgs, ... }:
pkgs.writeScriptBin "cadoras" ''
  ${builtins.readFile (inputs.tools + "/bash/shared.sh")}
  ${builtins.readFile (inputs.tools + "/bash/cadoras.sh")}
''
