{ pkgs, unstable, lib, config, ... }:
{
  config = lib.mkIf config.my.engineering.enable {
    home.packages = [
      #unstable.prusa-slicer
      unstable.orca-slicer
    ];
     xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/prusaslicer" = ["PrusaSlicer.desktop"];
        "model/stl" = ["PrusaSlicer.desktop" "OrcaSlicer.desktop"];
        "application/vnd.ms-pki.stl" = ["PrusaSlicer.desktop" "OrcaSlicer.desktop"];
    };


  };
}
