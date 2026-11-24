{
  lib,
  mkDerivation,
  fetchFromGitHub,
  gnuradio,
  cmake,
  pkg-config,
  spdlog,
  logLib,
  mpir,
  gmp,
  boost,
  python,
  gnuradioOlder,
}:

mkDerivation {
  pname = "gr-air-modes";
  version = "2020";

  src = fetchFromGitHub {
    owner = "bistromath";
    repo = "gr-air-modes";
    rev = "9e2515a56609658f168f0c833a14ca4d2332713e";
    hash = "sha256-Dehk5RgGeeR5JA/gGO7deEppHswAoQoMkspYRgkW7NE=";
  };
  disabled = gnuradioOlder "3.6";

  outputs = [
    "out"
    "dev"
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    spdlog
    logLib
    mpir
    gmp
    boost
  ]
  ++ lib.optionals (gnuradio.hasFeature "python-support") [
    python.pkgs.pybind11
    python.pkgs.numpy
  ];

  cmakeFlags = [
    (lib.cmakeBool "ENABLE_PYTHON" (gnuradio.hasFeature "python-support"))
  ];

  meta = {
    description = "ADS-B";
    homepage = "https://github.com/bistromath/gr-air-modes";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
