{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.sigrok.enable = lib.mkEnableOption "Install SigRok";
  };
  config = lib.mkIf config.my.sigrok.enable {

    home.packages = with unstable; [
      sigrok-cli
      libsigrok
      libsigrokdecode
      libserialport
      sigrok-firmware-fx2lafw
      #smuview
      #pulseview
    ];

    xdg.desktopEntries."org.sigrok.SmuView" = {
      name = "SmuView";
      genericName = "A sigrok GUI for power supplies, loads and measurement devices";
      comment = "SmuView is a Qt based source measure unit GUI for sigrok.";
      categories = [ "Development" "Electronics" ];
      icon = "smuview";
      type = "Application";
      exec = "smuview %U";
      startupNotify = true;

      actions = {
        DPS5005 = {
          exec = "smuview -D -d rdtech-dps:/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0 %U";
          name = "RDTech DPS5005 USB";
        };
        DPS5005-BT = {
          exec = "smuview -D -d rdtech-dps:/dev/rfcomm1 %U";
          name = "RDTech DPS5005 rfcomm";
        };
        LABPS3005DN = {
          exec = "smuview -D -d korad-kaxxxxp:conn=/dev/velleman-LABPS3005DN %U"; 
          name = "Velleman LABPS3005DN";
        };
      };
    };
  };
}

/*

[Desktop Action DPS5005]

[Desktop Action LABPS3005DN]

*/
