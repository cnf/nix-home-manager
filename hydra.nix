{ pkgs, lib, config, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nvtopPackages.amd
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
  #];
  my.zsh.enable = true;
  my.git.enable = true;
  my.vim.enable = true;
  my.golang.enable = true;
  my.desktop.enable = true;
  my.hyprland.enable = true;
  my.email.enable = true;
  my.vscode.enable = true;
  my.firefox.enable = true;
  my.obsidian.enable = true;
  my.discord.enable = true;
  my.sdr.enable = true;
  my.engineering.enable = true;
  my.sigrok.enable = true;
  my.yubikey.enable = true;
  my.mqtt.enable = true;
  my.gaming.enable = true;
  my.zotero.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
