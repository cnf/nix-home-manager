final: prev: 
{
  freecad = prev.freecad.overrideAttrs (old: new: {
    version = "1.1.0";
    src = prev.fetchFromGitHub {
      owner = "FreeCAD";
      repo = "FreeCAD";
      rev = new.version;
      hash = "sha256-u7RYSImUMAgKaAQSAGCFha++RufpZ/QuHAirbSFOUCI=";
      fetchSubmodules = true;
    };
  });
}
