{ pkgs, unstable, ... }:
{
  imports = [
    #./prusa-slicer.nix
    ./desktop
    ./devel
    ./engineering
    ./funshoot
    ./hyprland
    ./debug
    ./sdr
    ./tryouts.nix
    ./helpers.nix
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {rocmSupport = true;};
  };
  home.packages = with pkgs; [
    assh
    ncdu # cli disk exporer
    usbtop
    net-tools

    dig
    mtr
    zip
    pv # pipe viewer
    ripgrep
  ];
}
