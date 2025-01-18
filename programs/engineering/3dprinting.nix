{ pkgs, unstable, lib, config, inputs, outputs, ... }:
{
  config = lib.mkIf config.my.engineering.enable {
    home.packages = with pkgs; [
      unstable.prusa-slicer
      orca-slicer
    ];
     xdg.mimeApps.defaultApplications = {
        "inode/directory" = ["org.kde.dolphin.desktop" "dolphin.desktop"];
        "x-scheme-handler/prusaslicer" = ["PrusaSlicer.desktop"];
    };


  };
}
