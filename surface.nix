{ pkgs, ... }:
#let
#  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
#in 
{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.assh
    pkgs.usbutils
  #  pkgs.terminator
  ];

  #home.file = {
  #};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  imports = [];
  my.git.enble = true;
  my.vim.enable = true;
  my.zsh.enable = true;
  my.sigrok.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
