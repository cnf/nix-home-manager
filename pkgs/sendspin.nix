{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchgit,
  cmake,
  pkg-config,
  makeWrapper,
  alsa-lib,
  portaudio,
  avahi-compat,
  libpulseaudio,
  pipewire,
  mdns
}:

let

  sendspinSrc = fetchFromGitHub {
    owner = "Sendspin";
    repo = "sendspin-cpp";
    # Use the value of SENDSPIN_GIT_TAG in the CLI CMakeLists.txt.
    rev = "v0.10.0";
    hash = "sha256-wzrrq/oB+8IhKr0fUTynrihpFaJ5iwlAVbc6PrizMZI=";
  };

  arduinoJsonSrc = fetchFromGitHub {
    owner = "bblanchon";
    repo = "ArduinoJson";
    rev = "v7.4.1";
    hash = "sha256-CvwL3FDsbQGLkZFC3Z/RWeiT9tO+7ZRpT65YUdRT5dQ=";
  };

  microFlacSrc = fetchgit {
    url = "https://github.com/esphome-libs/micro-flac.git";
    rev = "v0.3.1";
    fetchSubmodules = true;
    hash = "sha256-mKpQA5ohvL4rAL5ZtXXCUT42UEy73ec2NWlQcomPzbA=";
  };

  microOpusSrc = fetchgit {
    url = "https://github.com/esphome-libs/micro-opus.git";
    rev = "v0.3.5";
    fetchSubmodules = true;
    hash = "sha256-OV5J8UgL81Rerotu2zjpR5LQfqnYb0e+KkFutP1INqo=";
  };

  ixWebSocketSrc = fetchFromGitHub {
    owner = "machinezone";
    repo = "IXWebSocket";
    rev = "v12.0.1";
    hash = "sha256-2QWIpLVIs2vGuMEhewDyihYdDQBz7SsOtfZ6pE67j2Q=";
  };

  noiseSrc = fetchFromGitHub {
    owner = "esphome-libs";
    repo = "noise-c";
    rev = "v0.1.13";
    hash = "sha256-5bu3Vh+8w4cVuU9n7oc20uhswJgxVtIeHoIzTjAr/Xo=";
  };

  ftxuiSrc = fetchFromGitHub {
    owner = "ArthurSonzogni";
    repo = "FTXUI";
    rev = "f921fad208912747c17d129a8ef75ec7624b6eec";
    hash = "sha256-hKdmzraAgKwvOGQXpglD9lm0465j92AAn2MhS9ZM4jA=";
  };

  runtimeLibs = [ 
    alsa-lib
    libpulseaudio
    pipewire
    
    mdns
    avahi-compat
    portaudio
  ];
in
stdenv.mkDerivation rec {
  pname = "sendspin-cpp-cli";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "Sendspin";
    repo = "sendspin-cpp-cli";
    rev = "v${version}";
    hash = "sha256-qk6GLYxyNrq7Y3EIo6XXTmYJFCFTKTMNTmq9N1DDP/o=";
  };


  nativeBuildInputs = [ cmake pkg-config makeWrapper ];
  buildInputs = runtimeLibs;

  cmakeFlags = [
    "-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
    "-DFETCHCONTENT_SOURCE_DIR_FTXUI=${ftxuiSrc}"
    "-DSENDSPIN_CLI_WITH_TUI=ON"
    "-DFETCHCONTENT_SOURCE_DIR_SENDSPIN=${sendspinSrc}"
    "-DFETCHCONTENT_SOURCE_DIR_ARDUINOJSON=${arduinoJsonSrc}"
    "-DFETCHCONTENT_SOURCE_DIR_MICRO_FLAC=${microFlacSrc}"
    "-DFETCHCONTENT_SOURCE_DIR_IXWEBSOCKET=${ixWebSocketSrc}"
    "-DFETCHCONTENT_SOURCE_DIR_NOISE_C=${noiseSrc}"
    "-DSENDSPIN_CLI_BUILD_TESTS=OFF"
  ];

  # micro-opus stages and patches its source during CMake configuration.
  # Copy it out of /nix/store first so those operations have a writable tree.
  preConfigure = ''
    cp -a ${microOpusSrc} "$NIX_BUILD_TOP/micro-opus-src"
    chmod -R u+w "$NIX_BUILD_TOP/micro-opus-src"
    cmakeFlagsArray+=(
      "-DFETCHCONTENT_SOURCE_DIR_MICRO_OPUS=$NIX_BUILD_TOP/micro-opus-src"
    )
  '';

  # Install only the CLI component, not the fetched dependency's staged files.
  installPhase = ''
    runHook preInstall
    cmake --install . --component sendspin-cli
    wrapProgram "$out/bin/sendspin-cli" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibs}"
    runHook postInstall
  '';


  meta = with lib; {
    description = "Sendspin command-line client";
    platforms = lib.platforms.linux;
    homepage = "https://github.com/Sendspin/sendspin-cpp-cli";
    changelog = "https://github.com/Sendspin/sendspin-cpp-cli/releases/tag/v${version}";
    license = licenses.asl20;
  };
}

