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
  pname = "gr-gsm";
  version = "latest";

  src = fetchFromGitHub {
    owner = "ptrkrysik";
    repo = "gr-gsm";
    rev = "2de47e28ce1fb9a518337bfc0add36c8e3cff5eb";
    hash = "sha256-OD3sVBBG+OoJ2f5CJ6KcdpVCgJWNdDjA9kiIuTklyPc=";
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
    description = "A set of tools for receiving information transmitted by GSM equipment/devices.";
    homepage = "https://github.com/ptrkrysik/gr-gsm";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
