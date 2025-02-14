{
  lib,
  pkgs,
  python3Packages,
  fetchurl,
}:
python3Packages.buildPythonApplication rec {
  pname = "ollama-gui";
  version = "0.0.1";
  pyproject = false;

  # src = fetchPypi {
  #   inherit pname version;
  #   sha256 = "sha256-NcScirWIfWImkfrO9D5ex5HLesPldq2DptTyx7l+jIE=";
  # };
  src = fetchurl {
    url = "https://raw.githubusercontent.com/MeNicefellow/ollama-gui/refs/heads/main/main.py";
    hash = "";
  };
  # build-system = with python3Packages; [
  #   setuptools
  #   hatchling
  # ];

  dependencies = with python3Packages; [ tkinter pystray ];

  meta = with lib; {
    description = "A simple graphical user interface for managing Ollama models. This tool provides a user-friendly way to view, start, and stop Ollama models without using the command line.";
    homepage = "https://github.com/MeNicefellow/ollama-gui";
    license = licenses.asl20;
    #maintainers = with maintainers; [ null ];
  };
}
