{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      hyprland-autoname-workspaces
    ];
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
      client_fullscreen = "<span>[{icon}]</span>"

      #client_dup_fullscreen = "[{icon}]{delim}{icon}{counter_unfocused_sup}"

      [class_active]
      #DEFAULT="<span color='#FF8514'>A{icon}</span>"
      #"DDDEFAULT": ""
      spotify = "<span foreground='#1ED760'> </span>"
      "(?i)plexamp" = "<span foreground='#EBAF00'>󰚺 </span>"
      mpv = "<span foreground='#520053'> </span>"
      "[Ff]reecad" = "<span foreground='#ff585d'> </span>"

      [class]
      DEFAULT = " "
      "(?i)firefox" = "󰈹 "
      "(?i)kitty" = " "
      #" "
      code = "󰨞 "
      freecad = " "
      1Password = " "
      #" "
      vlc = "󰕼 "
      mpv = " "
      kicad = " "
      obsidian = " "
      #" " #
      nm-connection-editor = " "
      pavucontrol = ""
      steam = " "
      #" "
      spotify = " "
      PrusaSlicer = ""
      qbittorrent = " "
      ".*transmission.*" = " "
      waybar = " "
      calibre-gui = " "
      "(?i)plexamp" = "󰚺 "
      wire = "󰁀 "
      wireshark-gtk = " "
      wlfreerdp = "󰀄"
      ".blueman-manager-wrapped" = "󰂳"
      gcr-prompter = " " 
      #" "
      geary = "󰴃 "
      mailspring = "󰴃 "
      thunderbird = " "

      # Gnome
      "org.gnome.Nautilus" = " "
      evince = " "

      # chat
      discord = ""
      Signal = " "
      telegramdesktop = " "
      slack = ""
      whatsapp-desktop = ""

      # KDE
      dolphin = " "
      okular = ""
      gwenview = " "

      # rare
      udiskie = " "
      chromium-browser = " "
      "(?i).*kooha" = ""
      gucharmap = " "
      

      # Wine
      bottles = " "
      wine = ""
      "fusion360.exe" = "󰻬"
      "explorer.exe" = " "

      #  

      #[initial_class]
      #"com.usebottles.bottles" = " "
      #"(?i)io.github.seadve.kooha" = " "

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

      [title_in_class."(xterm|(?i)kitty|alacritty)"]
      "(?i)^(n?)vim" = " " 
      # " "
      btop = ""
      htop = " "
      "nh " = "󱄅 "

      [title_in_class_active."(?i)firefox"]
      "YouTube" = "<span color='red'> </span>"
      #"Amazon" = " "
      #"DuckDuckGo" = "󰇥 "
      "Google" = " "
      "gmail" = "󰊫 "
      "Home Assistant" = "<span color='#1ABCF2'>󰟐 </span>"
      "GitHub" = " "

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
