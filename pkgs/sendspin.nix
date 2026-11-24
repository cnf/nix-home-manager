{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchgit,
  cmake,
  pkg-config,
  makeWrapper,
  alsa-lib,
  libpulseaudio,
  pipewire,
  mdns,
  avahi-compat,
  portaudio
}:

let
  arduinojson = fetchFromGitHub {
    owner = "bblanchon";
    repo = "ArduinoJson";
    rev = "v7.4.1";
    hash = "sha256-CvwL3FDsbQGLkZFC3Z/RWeiT9tO+7ZRpT65YUdRT5dQ=";
  };

  microFlac = fetchgit {
    url = "https://github.com/esphome-libs/micro-flac.git";
    rev = "v0.3.1";
    fetchSubmodules = true;
    hash = "sha256-mKpQA5ohvL4rAL5ZtXXCUT42UEy73ec2NWlQcomPzbA=";
  };

  microOpus = fetchgit {
    url = "https://github.com/esphome-libs/micro-opus.git";
    rev = "v0.3.5";
    fetchSubmodules = true;
    hash = "sha256-OV5J8UgL81Rerotu2zjpR5LQfqnYb0e+KkFutP1INqo=";
  };

  ixWebSocket = fetchFromGitHub {
    owner = "machinezone";
    repo = "IXWebSocket";
    rev = "v12.0.1";
    hash = "sha256-2QWIpLVIs2vGuMEhewDyihYdDQBz7SsOtfZ6pE67j2Q=";
  };

  noiseC = fetchFromGitHub {
    owner = "esphome-libs";
    repo = "noise-c";
    rev = "v0.1.13";
    hash = "sha256-5bu3Vh+8w4cVuU9n7oc20uhswJgxVtIeHoIzTjAr/Xo=";
  };

  audioLibs = [ 
    alsa-lib
    libpulseaudio
    pipewire
    
    mdns
    avahi-compat
    portaudio
  ];
in
stdenv.mkDerivation {
  pname = "sendspin-cpp";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "Sendspin";
    repo = "sendspin-cpp";
    rev = "main";
    hash = "sha256-CJTmzWiX3p46r/tnuMm3tmGDrjgxnqos8fXX3M+qsd0=";
  };

  nativeBuildInputs = [ cmake pkg-config makeWrapper ];
  buildInputs = audioLibs;


  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DFETCHCONTENT_SOURCE_DIR_ARDUINOJSON=${arduinojson}"
    "-DFETCHCONTENT_SOURCE_DIR_MICRO_FLAC=${microFlac}"
    "-DFETCHCONTENT_SOURCE_DIR_IXWEBSOCKET=${ixWebSocket}"
    "-DFETCHCONTENT_SOURCE_DIR_NOISE_C=${noiseC}"
    "-DBUILD_EXAMPLES=ON"
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail \
        'add_subdirectory(examples/tui_client)' \
        'message(STATUS "Skipping TUI client in Nix build")'
  '';

  preConfigure = ''
    cp -a ${microOpus} ./micro-opus-src
    chmod -R u+w ./micro-opus-src
    cmakeFlagsArray+=("-DFETCHCONTENT_SOURCE_DIR_MICRO_OPUS=$PWD/micro-opus-src")
  '';


  postInstall = ''
    for exe in "$out"/bin/*; do
      [ -f "$exe" ] && wrapProgram "$exe" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath audioLibs}"
    done
  '';

  meta = {
    description = "Sendspin C++ client";
    platforms = lib.platforms.linux;
  };
}

