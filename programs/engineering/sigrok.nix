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
      smuview
      pulseview
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
        CAVE = {
          exec = "smuview -D -d scpi-dmm:conn=/dev/tty-OWON-dmm:serialcomm=115200/8n1 -d korad-kaxxxxp:conn=/dev/tty-CP2102 -d rdtech-tc:conn=/dev/TCC66 -d rdtech-um:conn=bt/rfcomm/00-BA-80-00-3C-CD %U"; 
          name = "Cave";
        };
        OWONXDM1041 = {
          exec = "smuview -D -d scpi-dmm:conn=/dev/tty-OWON-dmm:serialcomm=115200/8n1 %U"; 
          name = "OWON XDM1041";
        };
        LABPS3005DN = {
          exec = "smuview -D -d korad-kaxxxxp:conn=/dev/tty-CP2102 %U"; 
          name = "Velleman LABPS3005DN";
        };
        TC66 = {
          exec = "smuview -D -d rdtech-tc:conn=/dev/ttyACM0 %U";
        };
        #DPS5005 = {
        #  exec = "smuview -D -d rdtech-dps:/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0 %U";
        #  name = "RDTech DPS5005 USB";
        #};
        #DPS5005-BT = {
        #  exec = "smuview -D -d rdtech-dps:/dev/rfcomm1 %U";
        #  name = "RDTech DPS5005 rfcomm";
        #};
      };
    };
  };
}

/*

[Desktop Action DPS5005]

[Desktop Action LABPS3005DN]

*/
