{ stdenvNoCC }:
  stdenvNoCC.mkDerivation rec {
    pname = "sddm-dukk-theme";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src/corners $out/share/sddm/themes/corners
    '';
    src = ./sddm;
  }
