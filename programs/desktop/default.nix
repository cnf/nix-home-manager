{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.desktop.enable = lib.mkEnableOption "Enable a graphical env";
  };
  imports = [
    ./discord.nix
    ./email.nix
    ./firefox.nix
    ./gaming.nix
    ./mime-types.nix
    ./mqtt.nix
    ./nixtools.nix
    ./obsidian.nix
    ./pdf.nix
    ./vscode.nix
    ./wine.nix
    ./yubi.nix
    ./zotero.nix
  ];
  config = lib.mkIf config.my.desktop.enable {
    # home.preferXdgDirectories = true;
    fonts.fontconfig.enable = true;
    fonts.fontconfig.defaultFonts = {
      emoji = ["Noto Color Emoji"];
      serif = ["DejaVu Serif"];
      sansSerif = ["JetBrainsMono Nerd Font" "Helvetica Neue LT Std" "Arimo Nerd Font"];
      monospace = ["SauceCodePro Nerd Font" "Source Code Pro NerdFont"];
    };
    programs.jq.enable = true;
    programs.mpv = {
      enable = true;
      scripts = [
        pkgs.mpvScripts.mpris
        pkgs.mpvScripts.modernx
        unstable.mpvScripts.smartskip
      ];
    };
    home.packages = with pkgs; [
      unstable._1password-cli
      unstable._1password-gui
      
      appimage-run
      pinentry
      # audio
      pavucontrol
      pulseaudio

      #video
      # mpv has a program. option above
      vlc
      wf-recorder

      # icons
      candy-icons
      nixos-icons
      cosmic-icons
      kdePackages.breeze-gtk
      kdePackages.breeze-icons
      
      

      # notification tools
      libnotify

      # fonts
      fontpreview
      font-manager
      gucharmap
      source-code-pro
      source-sans-pro
      font-awesome
      liberation_ttf
      mplus-outline-fonts.githubRelease
      nerdfonts
      unstable.helvetica-neue-lt-std
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      emojione
      proggyfonts
      weather-icons
      material-icons
      material-design-icons

      unstable.spotify
      onedrive
      onedrivegui

      qalculate-qt

      qbittorrent
    ];
    
  };

}
