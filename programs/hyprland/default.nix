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
    ./locker.nix
    ./dunst.nix
    ./kitty.nix
    ./waybar
    ./nwg.nix
    ./osd.nix
    ./launcher.nix
    ./clipboard.nix
    ./kanshi.nix
    ./eww.nix
  ];
}
