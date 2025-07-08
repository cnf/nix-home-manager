{ pkgs, lib, config, inputs, ... }:
{
  home.packages = with pkgs; [
    nvtopPackages.amd
  #  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  #imports = [
  #];
  my.altbrowsers.enable = true;
  my.davinci.enable = false;
  my.desktop.enable = true;
  my.discord.enable = true;
  my.email.enable = true;
  my.engineering.enable = true;
  my.firefox.enable = true;
  my.funshoot.enable = true;
  my.gaming.enable = true;
  my.git.enable = true;
  my.golang.enable = true;
  my.hyprland.enable = true;
  my.man.enable = true;
  my.messaging.enable = true;
  my.mqtt.enable = true;
  my.music.enable = true;
  my.nixtools.enable = true;
  my.obsidian.enable = true;
  my.sdr.enable = true;
  my.sigrok.enable = true;
  my.synodrive.enable = true;
  my.tryouts.enable = true;
  my.vim.enable = true;
  my.vscode.enable = true;
  my.wine.enable = true;
  my.wireshark.enable = true;
  my.yubikey.enable = true;
  my.zotero.enable = true;
  my.zsh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
