{ pkgs, lib, config, inputs, ... }:
{
  options = {
    #sdr.enable = lib.mkEnableOption "Enable SDR Packages";
    sigrok.enable = lib.mkEnableOption "Install SigRok";
  };
  config = lib.mkIf config.sigrok.enable {

    home.packages = with pkgs; [
      sigrok-cli
      libsigrok
      libsigrokdecode
      sigrok-firmware-fx2lafw
      smuview
      pulseview

    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
