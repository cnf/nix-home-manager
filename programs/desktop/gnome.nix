{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    gtk.gtk4.theme = config.gtk.theme;
    home.packages = with pkgs; [
      gnome-online-accounts
      blanket
      cartridges
      d-spy
      gaphor
      gnome-firmware
      gnome-graphs
      gnome-network-displays
      gnome-obfuscate
      gnumeric
      impression
      paper-clip
      seahorse
      snapshot
      tuba
      evince
    ];
  };
}
