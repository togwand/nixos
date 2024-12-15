{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
config = lib.mkIf config.derivations.rice.crosscode-grub.enable import ( pkgs.stdenv.mkDerivation {
  pname = "arknights-grub";
  version = "default";
  src = inputs.rice;
  installPhase = ''
    mkdir -p $out
    cp -r grub/arknights/* $out
  '';
} {inherit pkgs;});}
