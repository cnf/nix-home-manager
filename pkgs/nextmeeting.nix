{
  lib,
  pkgs,
  python3Packages,
  fetchPypi,
}:
python3Packages.buildPythonPackage rec {
  pname = "nextmeeting";
  version = "3.1.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    #hash = "sha256-nRaPReRWv8BdgfecmQEQ/DmbpNnOJ+Rzh/nA0YUeTfU="; #2.0.0
    #hash = "sha256-wNwC8kx+OVq1vw2d1qGHm4E9dA0GIVXl0M7J3ulK2Gw="; # 3.0.0
    hash = "sha256-KmKBqaHDbJJqmzPIL+TS5Vc8xwBQUgfE1/AAPuYceQE=";
  };
  build-system = with python3Packages; [
    setuptools
    hatchling
    caldav
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
