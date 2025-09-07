{ pkgs, lib, config, unstable, ... }:
{
  config = lib.mkIf config.my.sdr.enable {
    home.packages = with pkgs; [
      rtl_433
      rtl-ais
      rtl-sdr
      #rtl-sdr-osmocom
      #rtl_fm_streamer
      #rtl-sdr-librtlsdr
      rtlamr

      libosmocore

      kalibrate-rtl
      kalibrate-hackrf

      dump1090
      multimon-ng
      csdr
      unstable.gnss-sdr # FIXME: undo

      iw
    ];

    xdg.desktopEntries.dump1090 = {
      name = "Dump 1090";
      type = "Application";
      comment="dump 1090 ADS-B info";
      icon = "sdr";
      exec = "dump1090 --device-type hackrf --net";
      terminal = true;
      categories = ["HamRadio"];
    };
    xdg.desktopEntries.rtl_433 = {
      name = "rtl_433";
      type = "Application";
      comment="rtl 433 cli tool";
      icon = "sdr";
      exec = "rtl_433 -d device=hackrf";
      terminal = true;
      categories = ["HamRadio"];
    };
  };
}
