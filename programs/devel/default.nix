{ pkgs, lib, config, inputs, ... }:
{
  imports = [
    ./git.nix
    ./golang.nix
    ./neovim.nix
    ./zsh.nix
  ];

  programs.direnv.enable = true;
  home.packages = with pkgs; [
  ];
}
