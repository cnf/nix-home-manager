{ pkgs, unstable, lib, config, ... }:
{
  config = lib.mkIf config.my.engineering.enable {
    home.packages = with pkgs;[
      #freecad-wayland
      unstable.freecad-wayland
      #unstable.freecad-weekly
      openscad
      graphviz
    ];

  };
}
