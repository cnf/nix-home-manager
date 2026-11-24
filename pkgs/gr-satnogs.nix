{
  lib,
  mkDerivation,
  fetchFromGitLab,
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

mkDerivation rec {
  pname = "gr-satnogs";
  version = "v3.1.0.1";

  src = fetchFromGitLab {
    owner = "librespacefoundation";
    repo = "satnogs/gr-satnogs";
    rev = "${version}";
    hash = "";
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
    description = "SATNOGS";
    homepage = "https://gitlab.com/librespacefoundation/satnogs/gr-satnogs";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
