{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    qt.enable = true;
    qt.platformTheme.name = "gtk";
    qt.style.name = "gtk2";
  };
}
