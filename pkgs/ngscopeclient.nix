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
  pname = "ngscopeclient";
  version = "";

  src = fetchFromGitHub {
    owner = "ngscopeclient";
    repo = "scopehal-apps";
    rev = "0.1.1";
    hash = "";
  };
  #disabled = gnuradioOlder "3.10";

  #outputs = [
  #  "out"
  #  "dev"
  #];

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
    #(lib.cmakeBool "ENABLE_PYTHON" (gnuradio.hasFeature "python-support"))
  ];

  meta = {
    description = "";
    homepage = "https://www.ngscopeclient.org/";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
}
