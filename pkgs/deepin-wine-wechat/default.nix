{ pkgsi686Linux
, fetchurl
, autoPatchelfHook
, makeWrapper
, lib
, callPackage
, pkgs
, bash
, p7zip
, ...
} @ args:

pkgsi686Linux.stdenv.mkDerivation rec {
  pname = "deepin-wine-wechat";
  version = "3.5.0.4";
  src = fetchurl {
    url = "https://com-store-packages.uniontech.com/appstore/pool/appstore/c/com.qq.weixin.deepin/com.qq.weixin.deepin_3.4.0.38deepin6_i386.deb";
    sha256 = "sha256-bZjto1n7+MS4k7rhXN2mBZDtfT1ABvmXeuQLxje2Srk=";
  };

  font = fetchurl {
    url = "https://media.githubusercontent.com/media/zglinus-for-nix/nix-source/master/Applications/wine/fake_simsun.tar.gz";
    sha256 = "sha256-lWAhpcLVl8D6ui0Zn2CmG7L3NP6k+TBwItquzSQ9DS0=";
  };

  wechat = fetchurl {
    url = "https://media.githubusercontent.com/media/zglinus-for-nix/nix-source/master/Applications/wine/WeChat3.5.0.4.tar.gz";
    sha256 = "sha256-Zx34H4rCc1IyW9AnNCm9Eioixykuf7xYk5F0gfw0X2M=";
  };

  mmmojo = fetchurl {
    url = "https://media.githubusercontent.com/media/zglinus-for-nix/nix-source/master/Applications/wine/mmmojo.tar.gz";
    sha256 = "sha256-+51Ks0SQi6uuatLUXxtUVRQnlBk23ZVXrS+JkWLhcmA=";
  };

  runfile = fetchurl {
    url = "https://media.githubusercontent.com/media/zglinus-for-nix/nix-source/master/Applications/wine/wechat.tar.gz";
    sha256 = "sha256-s13m2klObKel2h7yknWSJO2hLMfqsK6aWC8pUxTheAA=";
  };

  # autoPatchelfHook 可以自动修改二进制文件
  nativeBuildInputs = [ autoPatchelfHook makeWrapper p7zip ];

  buildInputs = with pkgsi686Linux;[
    xorg.libXext
    xorg.libX11
    udis86
  ];

  unpackPhase = ''
    ar x ${src}
    tar xf data.tar.xz
    tar xf ${font}
    tar xf ${wechat}
    tar xf ${mmmojo}
    tar xf ${runfile}
  '';

  installPhase = ''
    mkdir temp
    mkdir -p $out/files
    mkdir -p $out/lib
    mkdir -p $out/share
    7z x -aoa "opt/apps/*/files/files.7z" -o"temp"
    rm -r "temp/drive_c/Program Files/Tencent/WeChat"
    install -m644 "WeChat3.5.0.4.exe" "temp/drive_c/Program Files/Tencent/"
    install -m644 "mmmojo.dll" "temp/drive_c/Program Files/Tencent/"
    install -m644 "mmmojo_64.dll" "temp/drive_c/Program Files/Tencent/"
    # Creating 'XPlugin/Plugins/XWeb' to forbid wechat browser creating crash logs
    mkdir -p "temp/drive_c/users/@current_user@/Application Data/Tencent/WeChat/XPlugin/Plugins/"
    touch "temp/drive_c/users/@current_user@/Application Data/Tencent/WeChat/XPlugin/Plugins/XWeb"
    mv fake_simsun.ttc $out/files
    ln -sf "$out/files/fake_simsun.ttc" "temp/drive_c/windows/Fonts/fake_simsun.ttc"
    7z a -t7z -r "$out/files/files.7z" "./temp/*"
    mv run.sh $out/files
    mv opt/apps/*/files/dlls/* $out/lib/
    mv opt/apps/*/entries/* $out/share/
    sed -i "
      s|3.9.0.28|${version}|
      s|START_SHELL_PATH=.*|START_SHELL_PATH=\$(whereis run_v4.sh \| cut -b 12-80)|
      s|export DEB_PACKAGE_NAME="com.qq.weixin.deepin"||
      s|deepin-wine6-stable|deepin-wine5|
      s|ARCHIVE_FILE_DIR=.*|ARCHIVE_FILE_DIR=$out/opt/file.7z|
      s|export WINEPREDLL=.*|export WINEPREDLL=$out/lib|
      s|WINEPREDLL=\"\$ARCHIVE_FILE_DIR/dlls\"|WINEPREDLL=\$WINEPREDLL|
      s|export LD_LIBRARY_PATH=.*|export LD_LIBRARY_PATH=/nix/store/lwvv4fns4d05h22cjd9r8axblgmdcjc3-freetype-2.12.1/lib|
      24 i export OUTPATH=$out
      s|WECHAT_INSTALLER-|WECHAT_INSTALLER|
      s|WeChatSetup|WeChat|
    " "$out/files/run.sh"
    sed -i "
      s|/opt/apps/com.qq.weixin.deepin/files|$out/opt/run.sh|
      s|wine6|wine5|
    " "$out/share/applications/com.qq.weixin.deepin.desktop"
  '';
}
