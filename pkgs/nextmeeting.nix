{
  lib,
  pkgs,
  python3Packages,
  fetchPypi,
}:
python3Packages.buildPythonPackage rec {
  pname = "nextmeeting";
  version = "2.0.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    #sha256 = "sha256-NcScirWIfWImkfrO9D5ex5HLesPldq2DptTyx7l+jIE=";
    hash = "sha256-nRaPReRWv8BdgfecmQEQ/DmbpNnOJ+Rzh/nA0YUeTfU=";
  };
  build-system = with python3Packages; [
    setuptools
    hatchling
  ];

  dependencies = [ pkgs.gcalcli ];

  meta = with lib; {
    description = "Show your calendar next meeting in your waybar or polybar";
    homepage = "https://github.com/chmouel/nextmeeting";
    changelog = "https://github.com/chmouel/nextmeeting/releases/tag/${version}";
    license = licenses.asl20;
    #maintainers = with maintainers; [ null ];
  };
}
