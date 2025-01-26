{ lib, ... }:
{
  options = {
    my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
    my.hyprland.nwg.enable = lib.mkEnableOption "Enable and configure nwg";
  };
  imports = [
    ./autoname-workspaces.nix
    ./clipboard.nix
    ./dunst.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kanshi.nix
    ./kitty.nix
    ./launcher
    ./osd.nix
    ./waybar
  ];
}
