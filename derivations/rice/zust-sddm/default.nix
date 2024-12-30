{ inputs, pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "zust-sddm";
  version = "default";
  src = inputs.rice;
  dontWrapQtApps = true;
  buildInputs = with pkgs.libsForQt5.qt5; [ qtgraphicaleffects ];
  installPhase =
    let
      basePath = "$out/share/sddm/themes/zust";
    in
    ''
      mkdir -p ${basePath}
      cp -r sddm/zust/* ${basePath}
    '';
}
