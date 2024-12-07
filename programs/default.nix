{ pkgs, lib, config, inputs, ... }:
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./golang.nix
    ./neovim.nix
    ./ele-lab.nix
    ./engineering.nix
    ./desktop
    ./sdr
    ./hyprland
  ];
}
