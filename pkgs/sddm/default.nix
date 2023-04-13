{ stdenv }:

stdenv.mkDerivation rec {
  src = /home/zgl/Downloads/sugar-candy;
  pname = "sugar-candy";
  version = "1.2";
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/sugar-candy
  '';

}

