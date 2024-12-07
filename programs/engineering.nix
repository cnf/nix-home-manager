{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.engineering.enable = lib.mkEnableOption "Install engineering stuff";
  };
  config = lib.mkIf config.my.engineering.enable {

    home.packages = with pkgs; [
      prusa-slicer
      freecad-wayland
      kicad
    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
