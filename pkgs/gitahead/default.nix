{ lib
, stdenv
, fetchFromGitHub
, cmake
, ...
} @ args:

stdenv.mkDerivation rec {
  pname = "gitahead";
  version = "2.6.3";
  src = fetchFromGitHub ({
    owner = "gitahead";
    repo = "gitahead";
    rev = "81df5b468fc3ebd148320d894e561fb097324b88";
    fetchSubmodules = true;
    #sha256 = "sha256-NyT5CpQeclSJ0b4Qr4McAJXwKgy6SWiUijkAgu6TTNM=";
  });

  enableParallelBuilding = true;
  dontFixCmake = true;

  # nativeBuildInputs 指定的是只有在构建时用到，运行时不会用到的软件包
  # 例如这里的用来生成 Makefile 的 CMake，和用来生成配置文件的 Python
  nativeBuildInputs = [
    cmake
    # 向打包环境加入 Python 和这几个包，preConfigure 中的命令需要用到
    # (python3.withPackages (p: with p; [ jinja2 pyyaml tabulate ]))
  ];

  # buildInputs 指定的是运行时也会用到的软件包
  buildInputs = [
  ];

  # 在配置步骤（Configure phase）之前运行的命令，用来启用所有的后量子加密算法
  preConfigure = ''
  '';

  #cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];

  # 手动指定安装命令，把 oqsprovider.so 复制到 $out/lib 文件夹下
  # 一般来说可执行文件放在 $out/bin，库文件放在 $out/lib，菜单图标等放在 $out/share
  # 但并非强制，你在 $out 下随便放都可以，只不过在其它地方调用会麻烦一些
  installPhase = ''
  '';
}