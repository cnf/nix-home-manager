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

  programs.git = (pkgs.callPackage ./programs/git.nix {}).programs.git;
  programs.neovim = (pkgs.callPackage ./programs/neovim.nix {}).programs.neovim;
  programs.zsh = (pkgs.callPackage ./programs/zsh.nix {}).programs.zsh;
  #programs.vscode = (pkgs.callPackage ./programs/vscode.nix {}).programs.vscode;
  #programs.go = (pkgs.callPackage ./programs/golang.nix {}).programs.go;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
