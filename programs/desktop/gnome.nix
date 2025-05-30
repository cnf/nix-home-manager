{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
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
      impression
      paper-clip
      seahorse
      snapshot
      tuba
    ];
  };
}
