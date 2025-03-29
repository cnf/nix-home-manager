{ config, lib, pkgs, unstable, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    fonts.fontconfig.enable = true;
    fonts.fontconfig.defaultFonts = {
      emoji = config.my.looks.font.emoji;
      serif = config.my.looks.font.serif;
      sansSerif = config.my.looks.font.sansSerif;
      monospace = config.my.looks.font.monospace;
      #emoji = ["Noto Color Emoji"];
      #serif = ["DejaVu Serif"];
      #sansSerif = ["Inter" "JetBrainsMono Nerd Font"];
      #monospace = ["SauceCodePro Nerd Font" "Source Code Pro"];
    };
    #fonts.packages = with pkgs; [
    #  nerd-fonts.sauce-code-pro
    #  nerd-fonts.arimo
    #  nerd-fonts.go-mono
    #  nerd-fonts.jetbrains-mono
    #  nerd-fonts.dejavu-sans-mono
    #  nerd-fonts.noto
    #  #nerdfonts
    #  source-code-pro
    #  source-sans-pro
    #  font-awesome
    #  liberation_ttf
    #  mplus-outline-fonts.githubRelease
    #  unstable.helvetica-neue-lt-std
    #  #noto-fonts
    #  #noto-fonts-cjk-sans
    #  noto-fonts-emoji
    #  #noto-fonts-emoji-blob-bin
    #  emojione
    #  #proggyfonts
    #];
    home.packages = with pkgs; [
      fontpreview
      font-manager
      gucharmap
      unstable.nerd-fonts.symbols-only
      unstable.nerd-fonts.sauce-code-pro
      unstable.nerd-fonts.arimo
      unstable.nerd-fonts.go-mono
      unstable.nerd-fonts.jetbrains-mono
      unstable.nerd-fonts.dejavu-sans-mono
      unstable.nerd-fonts.noto
      #nerdfonts
      nerd-font-patcher
      unstable.helvetica-neue-lt-std
   ];
 };
}
