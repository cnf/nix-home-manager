{ pkgs, lib, config, inputs, ... }:
{
  home.packages = [
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  imports = [
  ];
  my.altbrowsers.enable = true;
  my.desktop.enable = true;
  my.discord.enable = false;
  my.hackrf.enable = true;
  my.firefox.enable = true;
  my.funshoot.enable = true;
  my.git.enable = true;
  my.golang.enable = true;
  my.hyprland.enable = true;
  my.nixtools.enable = true;
  my.obsidian.enable = false;
  my.sdr.enable = true;
  my.sigrok.enable = true;
  my.vim.enable = true;
  my.vscode.enable = true;
  my.yubikey.enable = true;
  my.zsh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
