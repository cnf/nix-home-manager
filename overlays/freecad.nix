final: prev: 
{
  freecad-weekly = (prev.freecad-wayland.overrideAttrs (old: new: {
    version = "1.1.0-weekly";
    src = prev.fetchFromGitHub {
      owner = "FreeCAD";
      repo = "FreeCAD";
      #rev = new.version;
      rev = "307a4661aff0974f90adbedae148543de85a463f";
      #hash = "sha256-u7RYSImUMAgKaAQSAGCFha++RufpZ/QuHAirbSFOUCI=";
      hash = "sha256-VwBrnhEvNJMXstE3dzdB6Z80rj9v74cIylsncB/qqw4=";
      fetchSubmodules = true;
    };
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
