{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.nwg.enable {
    home.packages = with pkgs; [
      nwg-drawer
      nwg-bar
      nwg-look
      nwg-menu
      nwg-panel
      nwg-wrapper
      nwg-displays
      nwg-dock-hyprland
      nwg-launchers
      nwg-dock
    ];
  };
}
