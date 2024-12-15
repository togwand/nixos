{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
config = lib.mkIf config.derivations.rice.crosscode-grub.enable import ( pkgs.stdenv.mkDerivation {
  pname = "crosscode-grub";
  version = "default";
  src = inputs.rice;
  installPhase = ''
    mkdir -p $out
    cp -r grub/crosscode/* $out
  '';
} {inherit pkgs;});}
