{ pkgs, lib, config, inputs, ... }:
#let
#  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
#in 
{
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.assh
  ];
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  imports = [
  ];
  my.zsh.enable = true;
  my.git.enable = true;
  my.vim.enable = true;
  my.golang.enable = false;
  my.desktop.enable = false;
  my.vscode.enable = false;
  my.firefox.enable = false;
  my.obsidian.enable = false;
  my.discord.enable = false;
  my.sdr.enable = false;
  my.sigrok.enable = false;
  my.hyprland.enable = false;
  my.hyprland.nwg.enable = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
