{ lib, config, pkgs, inputs, ... }:
let
  ignis = inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.ignis.overrideAttrs (final: prev: {
    buildInputs = prev.buildInputs ++ [
      pkgs.python312Packages.jinja2
      pkgs.python312Packages.pillow
      pkgs.python312Packages.materialyoucolor
      pkgs.python312Packages.humanize
      pkgs.python312Packages.psutil
    ];
  });

in
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = [
      ignis
      #inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.ignis
    ];
  };
}
