{ stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  src = fetchurl {
    url = "https://media.githubusercontent.com/media/zglinus-for-nix/zglinus-s-NUR/master/pkgs/wps/Fonts.tar.gz";
  };
  pname = "sha256";
  version = "1.2";
  dontBuild = true;

}

