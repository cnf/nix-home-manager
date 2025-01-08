{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.desktop.enable = lib.mkEnableOption "Enable a graphical env";
  };
  imports = [
    ./mime-types.nix
    ./pdf.nix
    ./email.nix
    ./vscode.nix
    ./firefox.nix
    ./obsidian.nix
    ./discord.nix
    ./mqtt.nix
    ./gaming.nix
    ./yubi.nix
    ./zotero.nix
    ./wine.nix
  ];
  config = lib.mkIf config.my.desktop.enable {
    # home.preferXdgDirectories = true;
    fonts.fontconfig.enable = true;
    fonts.fontconfig.defaultFonts = {
      emoji = ["Noto Color Emoji"];
      serif = ["DejaVu Serif"];
      sansSerif = ["Helvetica Neue LT Std" "Arimo Nerd Font"];
      monospace = ["Source Code Pro NerdFont"];
    };
    programs.jq.enable = true;
    home.packages = with pkgs; [
      unstable._1password-cli
      unstable._1password-gui
      appimage-run
      pinentry
      # audio
      pavucontrol
      pulseaudio

      #video
      mpv
      vlc

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
      helvetica-neue-lt-std
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      emojione
      proggyfonts
      weather-icons
      material-icons
      material-design-icons

      spotify
      onedrive
      onedrivegui

      qalculate-qt
    ];
    
  };

}
