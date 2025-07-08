{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.email.enable = lib.mkEnableOption "Install email stuff";
  };
  config = lib.mkIf config.my.email.enable {
    home.packages = with pkgs; [
      thunderbird #sucks, but everything else seems to suck more...
      # evolution
      # evolution-ews
      # evolution-data-server-gtk4
      #geary # fixed with panel sizes, auto marks as read on select, not configurable
      bluemail
    ];
    #services.gnome.evolution-data-server.enable = true;
    #programs.evolution = {
    #  enable = true;
    #  plugins = [
    #    pkgs.evolution-data-server-gtk4
    #  ];
    #};
    #programs.thunderbird = {
    #  enable = true;
    #  settings = {
    #    "calendar.alarms.showmissed" = false;
    #    "privacy.donottrackheader.enabled" = true;
    #    "app.update.auto" = false;
    #  };
    #};
  };
}
