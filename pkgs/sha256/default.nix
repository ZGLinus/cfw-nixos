{ stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  src = fetchurl {
    url = "https://media.githubusercontent.com/media/zglinus-for-nix/zglinus-s-NUR/master/pkgs/sddm/sugar-candy-magic.tar.gz";
    #sha256 ="sha256-xVwlMygty1iDdT5FJ6Fr7pPeiDzUwOFAheOYEBPdJFM=";
  };
  pname = "sha256";
  version = "1.2";
  dontBuild = true;

}

