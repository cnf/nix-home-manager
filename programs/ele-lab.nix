{ pkgs, lib, config, inputs, ... }:
{
  options = {
    #sdr.enable = lib.mkEnableOption "Enable SDR Packages";
    my.sigrok.enable = lib.mkEnableOption "Install SigRok";
  };
  config = lib.mkIf config.my.sigrok.enable {

    home.packages = with pkgs; [
      sigrok-cli
      libsigrok
      libsigrokdecode
      sigrok-firmware-fx2lafw
      #smuview # new in 24.11
      pulseview

    ];
    #programs.pulseview.enable = true;

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
