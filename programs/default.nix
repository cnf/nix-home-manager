{ pkgs, lib, config, inputs, ... }:
{
  imports = [
    ./devel
    ./zsh.nix
    ./git.nix
    ./golang.nix
    ./neovim.nix
    ./ele-lab.nix
    ./engineering.nix
    #./prusa-slicer.nix
    ./desktop
    ./sdr
    ./hyprland
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
