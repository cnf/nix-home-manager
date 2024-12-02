{ pkgs, lib, config, inputs, ... }:
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./golang.nix
    ./neovim.nix
    ./desktop
    ./sdr
    ./hyprland
  ];
}
