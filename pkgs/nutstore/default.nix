{ stdenv
, fetchurl
, autoPatchelfHook
, makeWrapper
, lib
, callPackage
, zlib
, xorg
, gcc-unwrapped
, alsa-lib
, ...
} @ args:

stdenv.mkDerivation rec {
  pname = "nutstore";
  version = "5.1.7";
  src = fetchurl {
    url = "https://www.jianguoyun.com/static/exe/installer/nutstore_linux_dist_x64.tar.gz";
    sha256 = "sha256-tV06uHRNqSFRlJqwiBcc+uH4BGSzVv0XIPJL4HCPFcQ=";
  };
  buildInputs = [
    zlib
    gcc-unwrapped
    alsa-lib
  ]++ (with xorg; [
    libXrender
    libXext
    libXi
    libXtst
  ]);
  # autoPatchelfHook 可以自动修改二进制文件
  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  unpackPhase = ''
    tar xf ${src}
  '';

  installPhase = ''
    mkdir -p $out
    mv * $out
    ls $out/bin
    $out/bin/install_core.sh
  '';
}