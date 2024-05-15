{ pkgs, lib, config, inputs, ... }:
{
  config = lib.mkIf config.my.sdr.enable {
    #hardware.hackrf.enable = true;

    home.packages = with pkgs; [
      hackrf
      kalibrate-hackrf
      soapysdr-with-plugins
      soapyhackrf
      #soapyremote
      cubicsdr
      sdrangel
      sdrpp
      gqrx
      urh
      librtlsdr
      rtl-sdr
      inspectrum
      gpredict
      gnss-sdr

      kismet

      hamlib

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
    xdg.desktopEntries.inspectrum = {
      name = "Inspectrum";
      type = "Application";
      comment="A tool for analysing captured signals, primarily from software-defined radio receivers.";
      icon = "inspectrum";
      exec = "inspectrum";
      terminal = false;
      categories = ["HamRadio"];
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
  };
}
