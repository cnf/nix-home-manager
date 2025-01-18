{ pkgs, lib, config, inputs, ... }:
{
  imports = [
    #./prusa-slicer.nix
    ./desktop
    ./devel
    ./ele-lab.nix
    ./engineering
    ./hyprland
    ./sdr
    ./tryouts.nix
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {rocmSupport = true;};
  };
  home.packages = with pkgs; [

    assh
    ncdu
    usbtop
  ];
}
