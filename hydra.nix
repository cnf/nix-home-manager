{ pkgs, lib, config, inputs, ... }:
#let
#  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
#in 
{
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    assh
  #  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  #home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  #};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  #imports = [
  #  ./configs/gnome.nix
  #];
  my.zsh.enable = true;
  my.git.enable = true;
  my.vim.enable = true;
  my.golang.enable = false;
  my.desktop.enable = true;
  my.vscode.enable = true;
  my.firefox.enable = true;
  my.obsidian.enable = false;
  my.discord.enable = true;
  my.sdr.enable = true;
  my.engineering.enable = true;
  my.mqtt.enable = true;
  my.hyprland.enable = true;
  my.hyprland.nwg.enable = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
