{ pkgs, unstable, lib, config, inputs, outputs, ... }:
{
  config = lib.mkIf config.my.engineering.enable {
    home.packages = with pkgs; [
      freecad-wayland
      graphviz
    ];

  };
}
