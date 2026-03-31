{ pkgs, lib, config, unstable, ... }:
{
  config = lib.mkIf config.my.sdr.enable {
    #hardware.hackrf.enable = true;

    home.packages = with pkgs; [
      cubicsdr
      gpredict
      gqrx
      inspectrum
      
      
      qradiolink
      
      unstable.sdrangel
      sdrpp
      #soapyremote
      soapyhackrf
      soapysdr-with-plugins
      unstable.satdump
      urh

      wsjtx

      direwolf

      pothos
      quisk


      chirp

      
      nanovna-saver
      nanovna-qt
      # https://cemaxecuter.com/?page_id=67

      #gr-framework
      (gnuradio.override {
        extraPackages = with gnuradioPackages; [
          osmosdr
          fosphor
          lora_sdr
        ];
        extraPythonPackages = with gnuradio.python.pkgs; [
          numpy
        ];
      })
    ];

    xdg.desktopEntries.SDR = {
      name = "SDR";
      comment = "Software Defined Radio";
      icon = "sdr";
      type = "Directory";
      terminal = null;
    };
    dconf.settings = {
#      "org/gnome/desktop/app-folders" = {
#        folder-children = ["SDR"];
#      };
#      "org/gnome/desktop/app-folders/folders/SDR" = {
#        name = "SDR";
#        apps = [
#          "dk.gqrx.gqrx.desktop"
#          "CubicSDR.desktop"
#          "urh.desktop"
#          "gnuradio.desktop"
#          "dump1090.desktop"
#        ];
#      };
#      "org/gnome/shell" = {
#        favorite-apps = [ "SDR.directory"];
#      };
    };

    xdg.desktopEntries.gnuradio = {
      name = "GNU Radio";
      type = "Application";
      settings = {
        #Path = "/home/funshoot/Projects/funshoot/QLCPlus/Shows/2024/Easter/";
        # Keywords = "qlc;light;controller;dmx;analog;midi;artnet;e131;osc;";
      };
      comment = "GNU Radio";
      icon = "${pkgs.gnuradio}/share/gnuradio/examples/qt-gui/gnuradio_logo.png";
      exec = "gnuradio-companion";
      terminal = false;
      categories = ["Science" "Education" "HamRadio"];
    };
    xdg.desktopEntries.inspectrum = {
      name = "Inspectrum";
      type = "Application";
      comment="A tool for analysing captured signals, primarily from software-defined radio receivers.";
      icon = "inspectrum";
      exec = "inspectrum";
      terminal = false;
      categories = ["Science" "Education" "HamRadio"];
    };
    xdg.desktopEntries.urh = {
      name = "Universal Radio Hacker";
      type = "Application";
      comment="Investigate wireless protocols like a boss";
      icon = "urh";
      exec = "urh";
      terminal = false;
      categories = ["Science" "Education" "HamRadio"];
    };
    xdg.desktopEntries.quisk = {
      name = "Quisk";
      type = "Application";
      comment="Quisk rhymes with 'brisk', and is QSK plus a few letters to make it easier to pronounce.";
      icon = "quisk";
      exec = "quisk";
      terminal = false;
      categories = ["Science" "Education" "HamRadio"];
    };
    xdg.desktopEntries.NanoVNASaver = {
      name = "NanoVNA Saver";
      type = "Application";
      comment="NanoVNASaver GUI";
      icon = "NanoVNASaver";
      exec = "NanoVNASaver";
      terminal = false;
      categories = ["Science" "Education" "HamRadio"];
    };
  };
}
