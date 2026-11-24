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
        version = "1.2.0"

        [format]
        dedup = true
        dedup_inactive_fullscreen = false
        delim = " " # NARROW NO-BREAK SPACE
        workspace = "{clients} "
        workspace_empty = "<span font_weight='heavy'>{name}</span>"
        client = "{icon} "
        client_fullscreen = "<span>〔{icon}〕</span>"
        client_active = "<span color='#FF8514'>{icon}</span>"
        client_dup = "<span>{icon}{counter_sup}</span>"
        client_dup_active = "*{icon}*{delim}{icon}{counter_unfocused_sup}"
        client_dup_fullscreen = "[{icon}]{delim}{icon}{counter_unfocused_sup}"

        [class]
        DEFAULT = "{class}: {title}"
        mpv = ""
        mailspring = "󰴃"
        PrusaSlicer = ""
        "org.gnome.Firmware" = ""
        "(?i)gitkraken" = " "
        "com/serial-studio.*" = "󰙜"
        "org.gnome.TextEditor" = ""
        "(?i)code" = "󰨞"
        "(?i)librewolf" = ""
        Signal = ""
        "fusion360.exe" = "󰻬"
        wine = "󰍲 "
        nm-connection-editor = ""
        dolphin = ""
        OpenSCAD = ""
        "io.missioncenter.MissionCenter" = ""
        "org.gnome.Logs" = "󱂅"
        vlc = "󰕼"
        bottles = ""
        "(?i)zotero" = "󰬡"
        gnome-disks = "󰋊"
        "org.openscad." = ""
        "org.gnome.World.PikaBackup" = "󰁯"
        "(?i).*kooha" = ""
        DEFAULT = " "
        udiskie = ""
        obsidian = ""
        pavucontrol = ""
        "(?i)freecad" = ""
        opensnitch-ui = "󰞵"
        "org.gnome.Calendar" = ""
        chromium-browser = ""
        cloud-drive-ui = ""
        discord = " "
        "org.gnome.font-viewer" = ""
        qbittorrent = ""
        gcr-prompter = ""
        "org.gnome.Nautilus" = "󰪶"
        "org.gnome.seahorse.Application" = "󱕴"
        pika-backup = "󰁯"
        "(?i)firefox" = "󰈹"
        "explorer.exe" = ""
        spotify = ""
        wire = "󰁀"
        wireshark-gtk = ""
        "org.gnome.SystemMonitor" = ""
        ".*transmission.*" = ""
        evince = ""
        "org.gnome.Settings" = ""
        calibre-gui = ""
        "org.raspberrypi." = ""
        geary = "󰴃"
        wlfreerdp = "󰢹"
        "org.gnome.baobab" = ""
        "org.gnome.Calculator" = ""
        1Password = "󰝳"
        xdg-desktop-portal-gtk = ""
        KTailctl = "󱗼"
        "se.grenangen." = "󱗼"
        "(?i)plexamp" = "󰚺"
        "(?i)opera" = ""
        thunderbird = ""
        "org.gnome.FileRoller" = ""
        "org.gnome.Loupe" = "󰥸"
        "org.gnome.Software" = ""
        "org.gnome.NautilusPreviewer" = ""
        simple-scan = "󰚫"
        "org.gnome.Snapshot" = ""
        "org.gnome.dspy" = "󰘘"
        kicad = ""
        whatsapp-desktop = ""
        slack = ""
        "Podman.*" = " "
        Varia = ""
        gucharmap = ""
        "org.gnome.Boxes" = ""
        ".blueman-manager-wrapped" = "󰂳"
        "org.freedesktop.Bustle" = "󰘘"
        "(?i)evolution.*" = "󰇯"
        "org.gnome.Maps" = " "
        "org.gnome.NetworkDisplays" = "󰀟"
        okular = ""
        steam = ""
        waybar = ""
        "(?i)kitty" = " "
        "dev.deedles.Trayscale" = "󰖂"
        eezstudio = "󰔃"
        telegramdesktop = ""
        gwenview = ""

        [class_active]
        "(?i)freecad" = "<span foreground='#ff585d'></span>"
        mpv = "<span foreground='#520053'></span>"
        "(?i)opera" = "<span foreground='#FF2338'></span>"
        "(?i)plexamp" = "<span foreground='#EBAF00'>󰚺</span>"
        spotify = "<span foreground='#1ED760'></span>"
        "(?i)zotero" = "<span foreground='#DB2C3A'>󰬡</span>"

        [initial_class]

        [initial_class_active]

        [workspaces_name]
        3 = "𝐈𝐈𝐈"
        12 = "𝐗𝐈𝐈"
        10 = "𝐗"
        5 = "𝐕  "
        4 = "I𝐕 "
        11 = "𝐗𝐈"
        2 = "𝐈𝐈 "
        9 = "𝐈𝐗"
        7 = "𝐕𝐈𝐈"
        1 = "𝐈  "
        6 = "𝐕𝐈 "
        8 = "𝐕𝐈𝐈𝐈"

        [title_in_class."(xdg-desktop-portal-gtk)"]
        File = ""
        Folder = "󰉓"

        [title_in_class."(xterm|(?i)kitty|alacritty)"]
        btop = ""
        nvtop = ""
        htop = ""
        "nh " = "󱄅"
        "(?i)^(n?)vim" = ""

        [title_in_class_active."(?i)firefox"]
        gmail = "󰊫"
        YouTube = "<span color='red'> </span>"
        GitHub = ""
        "Home Assistant" = "<span color='#1ABCF2'>󰟐</span>"
        Google = ""

        [title_in_initial_class]

        [title_in_initial_class_active]

        [initial_title_in_class]

        [initial_title_in_class_active]

        [initial_title_in_initial_class]

        [initial_title_in_initial_class_active]

        [exclude]
        "(?i)TestApp" = ""
        "" = "^$"
        "[Ss]team" = "^(Friends List.*)?$"
        "(?i)fcitx" = ".*"
        aProgram = "^$"

    '';
  };
}
