{
  inputs,
  pkgs,
  self,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "crosscode-grub";
  version = "default";
  src = inputs.rice;
  installPhase = ''
    mkdir -p $out
    cp -r grub/crosscode/* $out
  '';
}
