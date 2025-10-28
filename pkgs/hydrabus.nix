{
  lib,
  #pkgs,
  python3Packages,
  #fetchPypi,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "pyHydrabus";
  version = "0.2.5";
  pyproject = true;

  #src = fetchPypi {
  #  inherit pname version;
  #  hash = "sha256-bw5kUepugkSPogVPHuEYgl3hMuO4twesnURh3iJYqGE=";
  #};
  src = fetchFromGitHub {
    owner = "HydraBus";
    repo = "pyHydrabus";
    rev = "793f82d4326c48d3bff292775525c7a2a976f403";
    hash = "sha256-iIxdmZTcxmymwktTB0m/jsS1HJ14dhNTb1DewnSdxpk=";
  };
  buildInputs = with python3Packages; [
    sphinx
    pyserial
  ];

  build-system = with python3Packages; [
    setuptools
    pyserial
  ];
  postPatch = ''
    ls -l
    cat setup.py
  '';

  #dependencies = [  ];

  meta = with lib; {
    description = "A python module that can be used to control the HydraFW from a Python script";
    homepage = "https://github.com/hydrabus/pyHydrabus";
    changelog = "https://github.com/hydrabus/pyHydrabus/releases/tag/v${version}";
    license = licenses.asl20;
    #maintainers = with maintainers; [ null ];
  };
}
