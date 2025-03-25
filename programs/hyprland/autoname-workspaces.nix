{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      hyprland-autoname-workspaces
    ];
    systemd.user.services.autoname-workspaces = {
      Unit = {
        Description = "Hyprland Autoname Workspaces";
        PartOf = "graphical-session.target";
        Requires = "tray.target";
        After = [ "graphical-session-pre.target" "tray.target"];
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = ''${pkgs.hyprland-autoname-workspaces}/bin/hyprland-autoname-workspaces'';
      };
    };
    xdg.configFile."hyprland-autoname-workspaces/config.toml".text = ''
      version = "1.1.15"
      [format]
      dedup = true
      dedup_inactive_fullscreen = false
      delim = " "
      workspace = "{clients}"
      workspace_empty = "{name}"
      client = "<span>{icon}</span>" 
      client_active = "<span color='#FF8514'>{icon}</span>"
      # These wrap either client or client_active
      client_dup = "<span>{icon}{counter_sup}</span>"
      client_fullscreen = "<span>〔{icon}〕</span>"

      #client_dup_fullscreen = "[{icon}]{delim}{icon}{counter_unfocused_sup}"

      [class_active]
      #DEFAULT="<span color='#FF8514'>A{icon}</span>"
      #"DDDEFAULT": ""
      "(?i)opera" = "<span foreground='#FF2338'></span>"
      spotify = "<span foreground='#1ED760'></span>"
      mpv = "<span foreground='#520053'></span>"
      "(?i)plexamp" = "<span foreground='#EBAF00'>󰚺</span>"
      "(?i)freecad" = "<span foreground='#ff585d'></span>"
      "(?i)zotero" = "<span foreground='#DB2C3A'>󰬡</span>"

      [class]
      DEFAULT = " "
      "(?i)firefox" = "󰈹"
      "(?i)librewolf" = ""
      "(?i)opera" = ""
      "(?i)kitty" = " "
      "(?i)code" = "󰨞"
      "(?i)freecad" = ""
      "org.openscad." = ""
      OpenSCAD = ""
      1Password = "󰝳"
      #""
      #" "
      vlc = "󰕼"
      mpv = ""
      kicad = ""
      obsidian = ""
      nm-connection-editor = ""
      pavucontrol = ""
      steam = ""
      spotify = ""
      PrusaSlicer = ""
      qbittorrent = ""
      ".*transmission.*" = ""
      Varia = ""
      waybar = ""
      calibre-gui = ""
      "(?i)plexamp" = "󰚺"
      wire = "󰁀"
      wireshark-gtk = ""
      wlfreerdp = "󰢹"
      ".blueman-manager-wrapped" = "󰂳"
      gcr-prompter = "" 
      "(?i)zotero" = "󰬡" 
      mailspring = "󰴃"
      thunderbird = ""
      opensnitch-ui = "󰞵"
      "Podman.*" = " "
      "dev.deedles.Trayscale" = "󰖂"
      KTailctl = "󱗼"
      "se.grenangen." = "󱗼"
      "(?i)gitkraken" = " "
      "cloud-drive-ui" = ""
      "io.missioncenter.MissionCenter" = ""
      "com/serial-studio.*" = "󰙜"


      "org.freedesktop.Bustle" = "󰘘"
      # Gnome
      "org.gnome.Calculator" = ""
      "org.gnome.Calendar" = ""
      "org.gnome.dspy" = "󰘘"
      "org.gnome.FileRoller" = ""
      "org.gnome.Firmware" = ""
      "org.gnome.Logs" = "󱂅"
      "org.gnome.Loupe" = "󰥸"
      "org.gnome.Maps" = " "
      "org.gnome.Nautilus" = "󰪶"
      "org.gnome.NautilusPreviewer" = ""
      "org.gnome.Snapshot" = ""
      "org.gnome.SystemMonitor" = ""
      "org.gnome.Settings" = ""
      "org.gnome.World.PikaBackup" = "󰁯"
      "org.gnome.baobab" = ""
      "org.gnome.font-viewer" = ""
      "org.gnome.TextEditor" = ""
      "org.gnome.seahorse.Application" = "󱕴"
      "org.gnome.Boxes" = ""
      simple-scan = "󰚫"
      gnome-disks = "󰋊"
      evince = ""
      geary = "󰴃"
      "(?i)evolution.*" = "󰇯"
      "xdg-desktop-portal-gtk" = ""

      # chat
      discord = " "
      Signal = ""
      telegramdesktop = ""
      slack = ""
      whatsapp-desktop = ""

      # KDE
      dolphin = ""
      okular = ""
      gwenview = ""

      # rare
      udiskie = ""
      chromium-browser = ""
      "(?i).*kooha" = ""
      gucharmap = ""
      

      # Wine
      bottles = ""
      wine = "󰍲 " #""
      "fusion360.exe" = "󰻬"
      "explorer.exe" = ""

      #  

      #[initial_class]
      #"com.usebottles.bottles" = ""
      #"(?i)io.github.seadve.kooha" = ""

      #[initial_class_active]

      [workspaces_name]
      # 𝐈 𝐕 𝐗 
      # 🯰 🯱 🯲 🯳 🯴 🯵 🯶 🯷 🯸 🯹
      1 = "𝐈  "
      2 = "𝐈𝐈 "
      3 = "𝐈𝐈𝐈"
      4 = "I𝐕 "
      5 = "𝐕  "
      6 = "𝐕𝐈 "
      7 = "𝐕𝐈𝐈"
      8 = "𝐕𝐈𝐈𝐈"
      9 = "𝐈𝐗"
      10 = "𝐗"
      11 = "𝐗𝐈"
      12 = "𝐗𝐈𝐈"

      [title_in_class."(xdg-desktop-portal-gtk)"]
      "File" = ""
      "Folder" = "󰉓"

      [title_in_class."(xterm|(?i)kitty|alacritty)"]
      "(?i)^(n?)vim" = "" 
      # ""
      btop = ""
      htop = ""
      nvtop = ""
      "nh " = "󱄅"

      [title_in_class_active."(?i)firefox"]
      "YouTube" = "<span color='red'> </span>"
      #"Amazon" = ""
      #"DuckDuckGo" = "󰇥"
      "Google" = ""
      "gmail" = "󰊫"
      "Home Assistant" = "<span color='#1ABCF2'>󰟐</span>"
      "GitHub" = ""

      #[title_in_initial_class]

      #[title_in_initial_class_active]

      #[initial_title_in_class]

      #[initial_title_in_class_active]

      #[initial_title_in_initial_class]

      #[initial_title_in_initial_class_active]

      [exclude]
      "" = "^$"
      "(?i)fcitx" = ".*"
      aProgram = "^$"
      "[Ss]team" = "^(Friends List.*)?$"
      "(?i)TestApp" = ""
    '';
  };
}
