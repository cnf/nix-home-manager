{ pkgs, lib, config, inputs, ... }:
{
  options = {
    sdr.enable = lib.mkEnableOption "Enable SDR Packages";
    hackrf.enable = lib.mkEnableOption "Install HackRF";
  };
  config = lib.mkIf config.sdr.enable {
    #hardware.hackrf.enable = true;

    home.packages = with pkgs; [
      hackrf
      kalibrate-hackrf
      soapysdr-with-plugins
      soapyhackrf
      cubicsdr
      gqrx
      urh
      librtlsdr
      dump1090

      kismet

      (gnuradio.override {
        extraPackages = with gnuradioPackages; [
          osmosdr
        ];
        extraPythonPackages = with gnuradio.python.pkgs; [
          numpy
        ];
      })
    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
    dconf.settings = {
      "org/gnome/desktop/app-folders" = {
        folder-children = ["SDR"];
      };
      "org/gnome/desktop/app-folders/folders/SDR" = {
        name = "SDR";
        apps = [
          "dk.gqrx.gqrx.desktop"
          "CubicSDR.desktop"
          "urh.desktop"
          "gnuradio.desktop"
          "dump1090.desktop"
        ];
      };
      "org/gnome/shell" = {
        favorite-apps = [ "SDR.directory"];
      };
    };

    xdg.desktopEntries.gnuradio = {
      name = "GNU Radio";
      type = "Application";
      settings = {
        #Path = "/home/funshoot/Projects/funshoot/QLCPlus/Shows/2024/Easter/";
        # Keywords = "qlc;light;controller;dmx;analog;midi;artnet;e131;osc;";
      };
      comment = "GNU Radio";
      #icon = "${pkgs.gnuradio}/share/doc/gnuradio-3.10.7.0/html/gnuradio_logo_icon.png";
      icon = "${pkgs.gnuradio}/share/gnuradio/examples/qt-gui/gnuradio_logo.png";
      exec = "gnuradio-companion";
      terminal = false;
      # mimeType = ["application/x-qlc-workspace"];
      categories = ["HamRadio"];
      #actions = {
      #  edit-show = {
      #    name = "Edit Show";
      #    exec = "qlcplus --open Easter\\ 2024.qxw";
      #  };
      #};
    };
    xdg.desktopEntries.urh = {
      name = "Universal Radio Hacker";
      type = "Application";
      comment="Investigate wireless protocols like a boss";
      icon = "urh";
      exec = "urh";
      terminal = false;
      categories = ["HamRadio"];
    };
    xdg.desktopEntries.dump1090 = {
      name = "Dump 1090";
      type = "Application";
      comment="dump 1090 ADS-B info";
      icon = "sdr";
      exec = "dump1090 --device-type hackrf --net";
      terminal = true;
      categories = ["HamRadio"];
    };
  };
}
