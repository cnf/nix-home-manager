{ pkgs, unstable, ... }:
{
    fonts.fontconfig.enable = true;
    fonts.fontconfig.defaultFonts = {
      emoji = ["Noto Color Emoji"];
      serif = ["DejaVu Serif"];
      sansSerif = ["Helvetica Neue LT Std" "JetBrainsMono Nerd Font" "Arimo Nerd Font"];
      monospace = ["SauceCodePro Nerd Font" "Source Code Pro"];
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
      nerdfonts
      unstable.helvetica-neue-lt-std
   ];

}
