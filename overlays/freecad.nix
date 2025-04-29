final: prev: 
{
  freecad-weekly = (prev.freecad.overrideAttrs (old: new: {
    version = "1.1.0-weekly";
    src =  builtins.fetchTarball {
      url = "https://github.com/FreeCAD/FreeCAD/tarball/e9f2e8fe92f7015c6ae0d7e3c45f12532f17d744";
      hash = "sha256-yS1TFwpsGXimDpleO8dQuMH/wfh1vIno2rCEKyeMzTM=";
    };
    #src = prev.fetchFromGitHub {
    #  owner = "FreeCAD";
    #  repo = "FreeCAD";
    #  #rev = new.version;
    #  rev = "e9f2e8fe92f7015c6ae0d7e3c45f12532f17d744";
    #  #hash = "sha256-u7RYSImUMAgKaAQSAGCFha++RufpZ/QuHAirbSFOUCI=";
    #  hash = "sha256-yS1TFwpsGXimDpleO8dQuMH/wfh1vIno2rCEKyeMzTM=";
    #  fetchSubmodules = true;
    #};
    buildInputs = old.buildInputs ++ [final.pcl];
    patches = [
      (prev.fetchpatch {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/nixpkgs-unstable/pkgs/by-name/fr/freecad/0001-NIXOS-don-t-ignore-PYTHONPATH.patch";
        hash = "sha256-PTSowNsb7f981DvZMUzZyREngHh3l8qqrokYO7Q5YtY=";
      })
      (prev.fetchpatch {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/nixpkgs-unstable/pkgs/by-name/fr/freecad/0002-FreeCad-OndselSolver-pkgconfig.patch";
        hash = "sha256-3nfidBHoznLgM9J33g7TxRSL2Z2F+++PsR+G476ov7c=";
      })
    ];
  })).override{withWayland = true; qtVersion = 6;};
}
