final: prev: 
{
  freecad-dev = prev.freecad-wayland.overrideAttrs (old: new: {
    version = "1.1.0";
    src = prev.fetchFromGitHub {
      owner = "FreeCAD";
      repo = "FreeCAD";
      #rev = new.version;
      rev = "main";
      hash = "sha256-u7RYSImUMAgKaAQSAGCFha++RufpZ/QuHAirbSFOUCI=";
      fetchSubmodules = true;
    };
  });
}
