{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.sddm-astronaut;
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
