{ pkgs, ... }:
#let
#  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
#in 
{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.assh
  #  pkgs.terminator
  ];

  #home.file = {
  #};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  imports = [./configs/gnome.nix];
  myGit.enble = true;
  myVim.enable = true;
  myZsh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
