{ pkgs, unstable, lib, config, ... }:
{
  options = { 
    my.desktop.enable = lib.mkEnableOption "Enable a graphical env";
  };
  imports = [
    ./altbrowsers.nix
    ./chromium.nix
    ./davinci.nix
    ./discord.nix
    ./email.nix
    ./firefox.nix
    ./fonts.nix
    ./gaming.nix
    ./gnome.nix
    ./kitty
    ./mqtt.nix
    ./nixtools.nix
    ./obsidian.nix
    ./pdf.nix
    ./synology.nix
    ./theme-vars.nix
    ./vscode.nix
    ./wine.nix
    ./wireshark.nix
    ./xdg-options.nix
    ./yubi.nix
    ./zotero.nix
  ];
  config = lib.mkIf config.my.desktop.enable {
    home.shellAliases = {
      open = "xdg-open";
    };
    #services.opensnitch-ui.enable = true;
    # home.preferXdgDirectories = true;
    home.sessionVariables = {
      VIRTUAL_ENV_DISABLE_PROMPT = 1;
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
      unstable.appimage-run
      pinentry
      # audio
      pavucontrol
      pulseaudio
      # nautilus-python

      #video
      # mpv has a program. option above
      vlc
      wf-recorder
      wl-screenrec

      # icons
      candy-icons
      nixos-icons
      cosmic-icons
      kdePackages.breeze-gtk
      #kdePackages.breeze-icons
      dracula-icon-theme
      kora-icon-theme
      
      

      # notification tools
      libnotify

      weather-icons
      material-icons
      material-design-icons

      unstable.spotify
      unstable.plexamp
      onedrive
      onedrivegui
      #unstable._1password-cli
      #unstable._1password-gui
      #tailscale-systray
      ktailctl
      unstable.my-tailscale-systray
      unstable.tail-tray
      podman-desktop
      varia

      qalculate-qt

      qbittorrent

      mission-center
    ];
    # services.trayscale.enable = true;
    
  };

}
