{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  #cmake,
  #pkg-config,
}:

stdenv.mkDerivation rec {
  pname = "ngscopeclient";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "ngscopeclient";
    repo = "scopehal-apps";
    rev = "v${version}";
    hash = "sha256-YgYjlxTrQyF3wwtcmj4CI1+YxDwiWy5PgHo/RXyw+xU=";
  };
  #disabled = gnuradioOlder "3.10";

  #outputs = [
  #  "out"
  #  "dev"
  #];

  nativeBuildInputs = with pkgs;[
    cmake
    yaml-cpp
    pkg-config
    libsigcxx
    gtk3
    glfw
    catch2
    hidapi

    spirv-tools
    glslang
    vulkan-headers
    vulkan-loader
    shaderc

  ];

  #buildInputs = [
  #  logLib
  #  mpir
  #  gmp
  #  boost
  #]
  #++ lib.optionals (gnuradio.hasFeature "python-support") [
  #  python.pkgs.pybind11
  #  python.pkgs.numpy
  #];

  cmakeFlags = [
    "NGSCOPECLIENT_VERSION_LONG=v${version}"
    "NGSCOPECLIENT_PACKAGE_VERSION=v${version}"
    "CMAKE_BUILD_TYPE=Release"
    "BUILD_TESTING=OFF"
    "CMAKE_MODULE_PATH=cmake"
    #(lib.cmakeBool "ENABLE_PYTHON" (gnuradio.hasFeature "python-support"))
  ];

  meta = {
    description = "";
    homepage = "https://www.ngscopeclient.org/";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
}
