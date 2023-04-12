{ stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  src = fetchurl {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
  };
  pname = "sha256";
  version = "1.2";
  dontBuild = true;

}

