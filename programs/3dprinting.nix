{ pkgs, lib, config, inputs, ... }:
{
  options = {
    #sdr.enable = lib.mkEnableOption "Enable SDR Packages";
    my.3dprint.enable = lib.mkEnableOption "Install 3dprinting stuff";
  };
  config = lib.mkIf config.my.3dprint.enable {

    home.packages = with pkgs; [
	prusa-slicer

    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
