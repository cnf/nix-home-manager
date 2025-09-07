{ lib, ... }:
{
  options = {
    my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
    my.hyprland.nwg.enable = lib.mkEnableOption "Enable and configure nwg";
  };
  imports = [
    ./autoname-workspaces.nix
    ./blueman.nix
    ./clipboard.nix
    ./backup.nix
    ./dunst.nix
    ./hypridle.nix
    ./hyprsunset.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    #./hyprshell.nix
    ./ignis.nix
    ./kanshi.nix
    ./launcher
    ./osd.nix
    ./theme.nix
    ./udiskie.nix
    ./waybar
  ];
}
