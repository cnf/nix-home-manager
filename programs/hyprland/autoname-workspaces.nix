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
      DEFAULT="<span color='#FF8514'>A{icon}</span>"
      spotify = "<span foreground='#1ED760'> </span>"
      mpv = "<span foreground='#520053'> </span>"
      "[Ff]reecad" = "<span foreground='#ff585d'> </span>"

      [class]
      DEFAULT = " "
      "(?i)firefox" = "󰈹 "
      "(?i)kitty" = " "
      code = "󰨞 "
      freecad = " "
      1Password = " "
      vlc = "󰕼 "
      mpv = " "
      kicad = " "
      obsidian = " "
      nm-connection-editor = " "
      pavucontrol = ""
      steam = " "
      spotify = " "
      PrusaSlicer = ""
      qbittorrent = " "
      ".*transmission.*" = " "
      waybar = " "
      calibre-gui = " "
      plexamp = "󰚺 "
      wire = "󰁀 "
      wireshark-gtk = " "
      wlfreerdp = "󰀄"

      # chat
      discord = ""
      Signal = " "
      telegramdesktop = " "
      slack = ""
      whatsapp-desktop = ""

      # KDE
      dolphin = " "
      okular = ""
      gwenview = " "

      # rare
      udiskie = " "
      "(?i).*kooha" = ""

      # Wine
      bottles = " "
      wine = ""
      "fusion360.exe" = "󰻬"
      "explorer.exe" = " "

      #[initial_class]
      #"com.usebottles.bottles" = " "
      #"(?i)io.github.seadve.kooha" = " "

      #[initial_class_active]

      [workspaces_name]
      1 = "I"
      2 = "II"
      3 = "III"
      4 = "IV"
      5 = "V"
      6 = "VI"
      7 = "VII"
      8 = "VIII"
      9 = "IX"
      10 = "X"

      [title_in_class."(xterm|(?i)kitty|alacritty)"]
      "(?i)^(n?)vim" = " "
      "btop" = " "
      "nh " = "󱄅 "

      [title_in_class_active."(?i)firefox"]
      "YouTube" = "<span color='red'> </span>"
      "Amazon" = " "
      "DuckDuckGo" = "󰇥 "
      "Google" = " "
      "gmail" = "󰊫 "
      "Home Assistant" = "󰟐 "
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
