{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    qt.enable = true;
    qt.platformTheme = "gtk2";
    qt.style = "gtk2";
  };
}
