{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "8993670e73d36f4e8edc70d13614fa05edc2575c";
    hash = "sha256-uEZX5J9uhPKakVFnjfzxjOvrvk4F4CNXthkIYroITl4=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
