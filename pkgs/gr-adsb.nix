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
  pname = "gr-adsb";
  version = "latest";

  src = fetchFromGitHub {
    owner = "mhostetter";
    repo = "gr-adsb";
    rev = "b1b5b139c8849d0090319ba12140bdc88fce236f";
    hash = "sha256-8oisTT2Be+H9jFuo8DuakeszFhFfsa02LZ0grC5yToI=";
  };
  disabled = gnuradioOlder "3.10";

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
    description = "A GNU Radio out-of-tree (OOT) module to demodulate and decode Automatic Dependent Surveillance Broadcast (ADS-B) messages.";
    homepage = "https://github.com/mhostetter/gr-adsb";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
