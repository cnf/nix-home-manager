{ lib, config, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    qt.enable = true;
    qt.platformTheme.name = "gtk3";
    qt.style.name = "gtk2";
  };
}
