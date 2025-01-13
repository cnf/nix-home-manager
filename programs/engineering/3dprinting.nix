{ pkgs, unstable, lib, config, inputs, outputs, ... }:
{
  config = lib.mkIf config.my.engineering.enable {
    home.packages = with pkgs; [
      unstable.prusa-slicer
      orca-slicer
    ];

  };
}
