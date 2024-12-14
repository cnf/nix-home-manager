{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
    my.hyprland.nwg.enable = lib.mkEnableOption "Enable and configure nwg";
  };
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprbinds.nix
    ./locker.nix
    ./dunst.nix
    ./kitty.nix
    ./waybar
    ./nwg.nix
    ./osd.nix
    ./launcher
    ./clipboard.nix
    ./kanshi.nix
    ./eww.nix
  ];
  #config.xdg.mimeApps.defaultApplications = {
  #  "inode/directory" = "dolphin.desktop";
  #};
}
