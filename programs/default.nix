{ pkgs, ... }:
{
  imports = [
    #./prusa-slicer.nix
    ./desktop
    ./devel
    ./engineering
    ./funshoot
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

    dig
    mtr
  ];
}
