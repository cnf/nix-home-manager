{ config, pkgs, unstable, ... }:
#let
#  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
#in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "funshoot";
  home.homeDirectory = "/home/funshoot";

  home.stateVersion = "23.11"; # Please read the comment before changing.


  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.qlcplus
    pkgs.midimonster
    pkgs.ola
    pkgs.xlights
  ];
    nixpkgs.overlays = [
    (final: prev: {qlcplus = unstable.qlcplus;})
    (final: prev: {midimonster = unstable.midimonster;})
    #(final: prev: {qlcplus = prev.qlcplus.overrideAttrs ( old: rec {
    #    version = "4.13.0";
    #    patches = [];
    #    src = prev.fetchFromGitHub {
    #      owner = "mcallegari";
    #      repo = "qlcplus";
    #      rev = "QLC+_${version}";
    #      sha256 = "sha256-d77bl64UF08KCQAr54v5uNaExQ67DE4rDesCah5MW4U=";
    #    };
    #  });
    #})
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cnf/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  #programs.vscode = {
  #  enable = true;
  #  
  #};
  xdg.desktopEntries.funshoot = {
    name = "Halloween 2024";
    type = "Application";
    settings = {
      Path = "/home/funshoot/Projects/funshoot/QLCPlus/Shows/2024/Easter/";
      Keywords = "qlc;light;controller;dmx;analog;midi;artnet;e131;osc;";
    };
    comment = "Halloween in 2024";
    icon = "qlcplus";
    #Exec=qlcplus --open %f -k;
    exec = "qlcplus -k -f --open Easter\\ 2024.qxw -p -c 1,1,32,32";
    terminal = false;
    mimeType = ["application/x-qlc-workspace"];
    categories = ["Qt" "Midi" "AudioVideo"];
    actions = {
      edit-show = {
        name = "Edit Show";
        exec = "qlcplus --open Easter\\ 2024.qxw";
      };
    };
  };
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [ "funshoot.desktop" "nautilus.desktop"];
    };
  };
  #xdg.desktopEntries.FunShoots = {
  #  name = "FunShoots";
  #  type = "Directory";
  #};

  programs.git = (pkgs.callPackage ./programs/git.nix {}).programs.git;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
