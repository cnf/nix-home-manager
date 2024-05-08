{ pkgs, lib, config, inputs, ... }:
{
  options = {
    sdr.enable = lib.mkEnableOption "Enable SDR Packages";
    hackrf.enable = lib.mkEnableOption "Install HackRF";
  };
  config = lib.mkIf config.sdr.enable {
    #hardware.hackrf.enable = true;

    home.packages = [
      pkgs.hackrf
      pkgs.kalibrate-hackrf
      pkgs.soapysdr-with-plugins
      pkgs.soapyhackrf
      pkgs.cubicsdr
      pkgs.gnuradio
      pkgs.gqrx
      pkgs.urh
      pkgs.librtlsdr
    ];

    xdg.desktopEntries.gnuradio = {
      name = "GNU Radio";
      type = "Application";
      settings = {
        #Path = "/home/funshoot/Projects/funshoot/QLCPlus/Shows/2024/Easter/";
        # Keywords = "qlc;light;controller;dmx;analog;midi;artnet;e131;osc;";
      };
      comment = "GNU Radio";
      icon = "gnuradio";
      exec = "gnuradio-companion";
      terminal = false;
      # mimeType = ["application/x-qlc-workspace"];
      categories = ["Audio" "AudioVideo" "HamRadio"];
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
      settings = {
        #Path = "/home/funshoot/Projects/funshoot/QLCPlus/Shows/2024/Easter/";
        # Keywords = "qlc;light;controller;dmx;analog;midi;artnet;e131;osc;";
      };
      comment = "Universal Radio Hacker";
      icon = "urh";
      exec = "urh";
      terminal = false;
      # mimeType = ["application/x-qlc-workspace"];
      categories = ["Audio" "AudioVideo" "HamRadio"];
      #actions = {
      #  edit-show = {
      #    name = "Edit Show";
      #    exec = "qlcplus --open Easter\\ 2024.qxw";
      #  };
      #};
    };
  };
}
