{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.engineering.enable = lib.mkEnableOption "Install engineering stuff";
  };
  config = lib.mkIf config.my.engineering.enable {

    home.packages = with pkgs; [
      unstable.prusa-slicer
      unstable.orca-slicer
      freecad-wayland
      kicad
      
      qFlipper
    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
