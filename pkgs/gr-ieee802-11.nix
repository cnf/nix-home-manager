{
  lib,
  mkDerivation,
  fetchFromGitHub,
  gnuradio,
  cmake,
  pkg-config,
 # logLib,
 # mpir,
 # gmp,
 # boost,
  #python,
  gnuradioOlder,
}:

mkDerivation {
  pname = "gr-ieee802-11";
  version = "unstable-2025-09-05";

  src = fetchFromGitHub {
    owner = "bastibl";
    repo = "gr-ieee802-11";
    rev = "202f63bfa6b6efa2f0943faf3d47086cd26dfb06";
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
    (lib.cmakeBool "ENABLE_PYTHON" (gnuradio.hasFeature "python-support"))
  ];

  meta = {
    description = "This an IEEE 802.11 a/g/p transceiver for GNU Radio that is fitted for operation with Ettus N210s and B210s. Interoperability was tested with many off-the-shelf WiFi cards and IEEE 802.11p prototypes. The code can also be used in simulations.";
    homepage = "https://github.com/bastibl/gr-ieee802-11";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
