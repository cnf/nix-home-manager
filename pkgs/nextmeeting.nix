{
  lib,
  pkgs,
  python3Packages,
  fetchPypi,
}:
python3Packages.buildPythonPackage rec {
  pname = "nextmeeting";
  version = "1.5.5";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-NcScirWIfWImkfrO9D5ex5HLesPldq2DptTyx7l+jIE=";
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
