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
  #  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  #  pkgs.qlcplus
  #  #pkgs.midimonster
  #  pkgs.ola
  #  pkgs.xlights
  #  pkgs.terminator
  ];
  #nixpkgs.overlays = [
  #  (final: prev: {qlcplus = unstable.qlcplus;})
    #(final: prev: {midimonster = unstable.midimonster;})
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
  #];

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
  #programs.git = (pkgs.callPackage ./programs/git.nix {}).programs.git;
  #programs.neovim = (pkgs.callPackage ./programs/neovim.nix {}).programs.neovim;
  #programs.zsh = (pkgs.callPackage ./programs/zsh.nix {}).programs.zsh;
  #programs.vscode = (pkgs.callPackage ./programs/vscode.nix {}).programs.vscode;
  #programs.go = (pkgs.callPackage ./programs/golang.nix {}).programs.go;
  imports = [
    ./configs/gnome.nix
  ];
  myGit.enable = true;
  myVim.enable = true;
  myZsh.enable = true;
  myVSCode.enable = true;
  myGolang.enable = false;
  sdr.enable = true;
  myFirefox.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
