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
    ./docs.nix
    ./email.nix
    ./firefox.nix
    ./fonts.nix
    ./gaming.nix
    ./gnome.nix
    ./kitty
    ./manpages.nix
    ./messaging.nix
    ./mqtt.nix
    ./music.nix
    ./nixtools.nix
    ./obsidian.nix
    ./pdf.nix
    ./synology.nix
    ./theme-vars.nix
    ./tidalcycles.nix
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
      pinentry-rofi
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


      #unstable._1password-cli
      #unstable._1password-gui
      # tailscale-systray # not very useful
      ktailctl #no added value
      trayscale # maybe?
      unstable.my-tailscale-systray
      unstable.tail-tray

      podman-desktop
      varia

      qalculate-qt

      qbittorrent

      mission-center
    ];
    systemd.user.services.appimage-menu-updater = {
      Unit = {
        Description = "AppImage Menu Updater";
        Type = "simple";
        PartOf = "graphical-session.target";
      };
      Service = {
        ExecStart = "/bin/sh -c 'HOME=%h ${lib.getBin unstable.my-appimage-menu-updater}'";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
    # services.trayscale.enable = true;
    
  };

}
