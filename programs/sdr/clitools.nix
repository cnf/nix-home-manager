{ pkgs, lib, config, inputs, ... }:
{
  config = lib.mkIf config.my.sdr.enable {
    home.packages = with pkgs; [
      rtl_433
      dump1090
      multimon-ng
      csdr
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
