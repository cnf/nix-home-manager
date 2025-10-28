{
  lib,
  stdenv,
  qtbase,
  qmake,
  qtserialport,
  wrapQtAppsHook,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "hydratool";
  version = "0.3.2.1";
  src = fetchFromGitHub {
    owner = "hydrabus";
    repo = "hydratool";
    rev = "v${version}";
    hash = "sha256-/trU0mke/dz3/S7lOG1z9AYJjXvjyQ3krtkMxjFid/Q=";
  };
  buildInputs = [ qtbase qtserialport ];
  nativeBuildInputs = [ qmake wrapQtAppsHook ];
  configurePhase = ''
    runHook preConfigure
    mkdir build
    cd build
    ls -l
    qmake $src/hydratool.pro PREFIX=$out
    ls -l
    runHook postConfigure
  '';
  
  installPhase = ''
    mkdir -p $out/bin
    cp hydratool $out/bin/
  '';


  #configurePhase = ''
  #  runHook preConfigure
  #
  #  ./configure -static -release -prefix ~/Qt591static -opensource -confirm-license -qt-zlib -qt-pcre -qt-libpng -qt-libjpeg -qt-freetype -qt-xcb -opengl desktop -make libs -nomake tools -nomake examples -nomake tests -skip wayland -skip purchasing -skip serialbus -skip script -skip scxml -skip speech -skip qtwebengine
  #  runHook postConfigure
  #'';
  meta = with lib; {
    homepage = "https://hydrabus.com";
    description = "Host software for HydraBus with HydraFW firmware";
    platforms = platforms.linux;
  };
}
