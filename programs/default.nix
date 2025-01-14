{ pkgs, lib, config, inputs, ... }:
{
  imports = [
    ./devel
    ./zsh.nix
    ./git.nix
    ./golang.nix
    ./neovim.nix
    ./ele-lab.nix
    ./engineering
    #./prusa-slicer.nix
    ./tryouts.nix
    ./desktop
    ./sdr
    ./hyprland
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {rocmSupport = true;};
  };
  programs.nh.enable = true;
  home.packages = with pkgs; [
    nix-inspect
    nix-output-monitor #purrdy alternative to nix commands
    nvd # compare generations

    assh
    ncdu
    usbtop
  ];
}
