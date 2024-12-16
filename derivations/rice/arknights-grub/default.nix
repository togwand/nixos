{ inputs, pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "arknights-grub";
  version = "default";
  src = inputs.rice;
  installPhase = ''
    mkdir -p $out
    cp -r grub/arknights/* $out
  '';
}
