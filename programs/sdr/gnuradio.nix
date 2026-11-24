{ pkgs, lib, config, unstable, ... }:
{
  config = lib.mkIf config.my.sdr.enable {
    #hardware.hackrf.enable = true;

    home.packages = with pkgs; [
      #gr-framework
      #(unstable.gnuradio.override {
      #  extraPackages = with unstable.gnuradioPackages; [
      #    osmosdr
      #    fosphor
      #    lora_sdr
      #    gr-difi
      #    gr-ieee802-11
      #    gr-adsb
      #  ];
      #  extraPythonPackages = with gnuradio.python.pkgs; [
      #    numpy
      #  ];
      #})
      gnuradio
    ];

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
  };
}
