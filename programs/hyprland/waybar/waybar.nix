{ pkgs, lib, config, inputs, unstable, ... }:
let
  app = pkgs.symlinkJoin {
    name = "waybar-scripts";
    paths = with pkgs; [
      (writeShellScriptBin "waybar-usbguard" (builtins.readFile ./bin/waybar-usbguard))
      (writeShellScriptBin "waybar-webcam" (builtins.readFile ./bin/waybar-webcam))
      (writeShellScriptBin "waybar-yubikey" (builtins.readFile ./bin/waybar-yubikey))
      coreutils
      gnugrep
      systemd
      dbus
      gawk
      procps
      jq
      psmisc
      #progress
      usbguard
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/waybar-usbguard  --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-webcam  --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-yubikey  --prefix PATH : $out/bin
    '';
  };
in
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      waybar-mpris
      gcalcli
      unstable.my-nextmeeting
    ];
    programs.waybar.systemd.enable = true;
    programs.waybar.systemd.target = "hyprland-session.target";
    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        height = 30;
        modules-left = [
          "custom/launcher"
          "hyprland/submap"
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
          "privacy"
          "custom/webcam"
          "custom/usbguard"
          "custom/yubikey"
        ];
        modules-right = [
          #"custom/agenda"
          #"group/privacywarn"

          "custom/leftend"
          "group/hardware"
          "mpris"
          #"custom/media"
          "pulseaudio"
          "pulseaudio/slider"
          "battery"
          "network"
          #"bluetooth"
          #"network#vpn"

          "tray"
          "custom/hyprlock"

          "clock"
        ];
        "custom/launcher" = {
          on-click = "rofi -show drun -drun-show-actions";
          on-click-right = "hyprsysteminfo";
          #format = " ";
          format = " ";
          # format = " ";
          tooltip = true;
          tooltip-format = "Launch Applications";
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = false;
          justify = "center";
          format = "{name}"; # we use {name} together with hyprland-autorename-workspaces
          #format = "{icon}";
          format-icons = {
            empty = " ";
            default = " ";
            urgent = " ";
            persistent = " ";
            special = "󰺕 ";
          };
          on-click = "activate";
          #persistent-workspaces = {
          #  "*" = 4;
          #};
        };
        "hyprland/submap" = {
          format = " {} ";
          max-length = 20;
          tooltip = false;
          on-click = "hyprctl dispatch submap reset";
        };
        "hyprland/window" = {
          format = "{}";
          icon = true;
          icon-size = 16;
          rewrite = {
            "(.*) — Mozilla Firefox" = "$1"; # ";
            "(.*) - Visual Studio Code" = "$1"; # ";
            "(.*) - Discord" = "$1"; # ";
            "(.*) - Obsidian v.*" = "$1";
            "(.*) - FreeCAD 1.*" = "$1";
            "(.*) - PrusaSlicer-.* based on Slic3r" = "$1";
            "PrusaSlicer-([0-9]+.[0-9]+.[0-9]+).* based on Slic3r" = "PrusaSlicer $1";
            "(.*) .(.*) - Frank Rosquin. - Autodesk Fusion Personal .Not for Commercial Use." = "$1 - $2";
            "(.*) (Frank Rosquin) - Autodesk Fusion Personal (Not for Commercial Use)" = "$1";
            "OneDriveGUI (.*)" = "$1";
          };
          separate-outputs = true;
        };
        "group/privacywarn" = {
          orientation = "inherit";
          modules = [
            "privacy"
            "custom/webcam"
          ];
        };
        privacy = {
          icon-size = 14;
        };
        "custom/webcam" = {
          return-type = "json";
          interval = 2;
          exec = "${app}/bin/waybar-webcam";
          format = "{icon}";
          format-icons = {
            recording = " "; #"󰖠";
          };
        };
        "custom/yubikey" = {
          hide-empty-text = true;
          return-type = "json";
          #format = "󰯄 {icon}";
          format = " {icon}";
          format-icons = {
            touch = "";
            HMAC = "󰌆";
            PGP = "󰌆";
            SSH = "󰣀";
            U2F = "󰦯";
            warn = "";
            default = "";
          };
          exec = "${app}/bin/waybar-yubikey";
        };
        "custom/usbguard" = {
          format-icons = {
            block = "󰕓";
          };
          format = "{icon}";
          tooltip-format = "{}";
          exec = "${app}/bin/waybar-usbguard";
          restart-interval = 30;
          return-type = "json";
          on-click = "dmenu-usbguard -d 'rofi -dmenu -i -p 󰕓 -no-custom -select block'";
          #on-click-middle = "${app}/bin/waybar-usbguard allow";
          #on-click-right = "${app}/bin/waybar-usbguard reject";
        };
        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-left-to-right = false;
          };
          modules = [
            "temperature"
            "idle_inhibitor"
            "backlight"
            "power-profiles-daemon"
            "memory"
            "cpu"
            "temperature#GPU"
          ];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
          reverse-scrolling = true;
          on-scroll-down = "swayosd-client --output-volume raise --max-volume=100";
          on-scroll-up = "swayosd-client --output-volume lower";
        };
        pulseaudio = {
          #scroll-step": 1, // %, can be a float
          format = "{icon}";
          format-muted = "󰝟";
          format-bluetooth = "{icon}󰂱";
          format-bluetooth-muted = "{icon}󰂱";
          format-source = " ";
          format-source-muted = " ";
          format-icons = {
              headphone = "󰋋 ";
              headphone-muted = "󰟎 ";
              headset = " ";
              headset-muted = "󰟎 ";
              hdmi = "󰡁";
              hifi = "󰴸 ";
              hifi-muted = "󰓄 ";
              #speaker = ["" "" "" " " " "];
              speaker = ["󰕿" "󰖀" "󰖀" "󰕾" "󰕾"];
              speaker-muted = " "; #"󰝟 "; #"󰖁 ";
              hands-free = " ";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" "" " " " "];
              default-muted = " ";
          };
          tooltip-format = "{icon} {volume:3}% {desc}\n{format_source} {source_volume:3}% {source_desc}";
          on-click = "pavucontrol";
          on-click-right = "rofi-pulse-select sink";
          on-click-middle = "rofi-pulse-select source";
          reverse-scrolling = true;
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "";
          format-no-controller = "";
          format-connected = "󰂱";
          #format-connected-battery = "󰂱 {device_battery_percentage}%";
          # format-device-preference= [ "device1", "device2" ]; # preference list deciding the displayed device
          interval = 30;
          on-click = "blueman-manager";
          on-click-middle = "rfkill toggle bluetooth";
          tooltip-format = "󰂯 {controller_alias} ({status})";
          tooltip-format-disabled = "󰂲 {controller_alias} ({status})";
          tooltip-format-connected = "󰂱 {controller_alias} ({num_connections} connected)\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias} {device_battery_percentage}%";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = ""; #
            deactivated = ""; #"";
          };
          tooltip-format-activated = "No sleep!";
          tooltip-format-deactivated = "Eh, Relax!";
        };
        cpu = {
          interval = 10;
          format = "{icon}"; #";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          max-length = 10;
          tooltip-format = "{load} {max_frequency}GHz {usage}%";
        };
        memory = {
          interval = 30;
          #format = "{}%  ";
          format = "{icon}";
          format-icons = ["󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
          max-length= 10;
          tooltip-format = "{}% {used:0.1f}G/{total:0.1f}G  ";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        backlight = {
          format = "{icon}";
          #format-icons = [" " " "]
          format-icons = ["󱩎 " "󱩏 " "󱩐 " "󱩑 " "󱩒 " "󱩓 " "󱩔 " "󱩕 " "󱩖 " "󰛨 "];
          tooltip-format = "Screen at {percent}%";
          on-scroll-up = "swayosd-client --brightness +5";
          on-scroll-down = "swayosd-client --brightness -1";
          reverse-scrolling = true;
          #scroll-step = 0.1;
          states =  {
            dim =  5;
            blind = 100;
          };

        };
        temperature = {
          format = "{icon}";
          format-critical = "{temperatureC}°C {icon}";
          hwmon-path = [
            "/sys/class/hwmon/hwmon6/temp1_input" # CPU
          ];
          critical-threshold = 95;
          format-icons = ["" "" "" "" ""];
          tooltip-format = "CPU {temperatureC}°C";
          tooltip = true;
          on-click = "hyprctl dispatch togglespecialworkspace visor";
        };
        "temperature#GPU" = {
          format = "{icon}";
          format-critical = "{temperatureC}°C {icon}";
          hwmon-path = [
            "/sys/class/hwmon/hwmon0/temp1_input" # GPU
          ];
          critical-threshold = 85;
          format-icons = ["" "" "" "" ""];
          tooltip-format = "GPU {temperatureC}°C";
          tooltip = true;
        };
        battery = {
          full-at = 85;
          format = "{icon}";
          format-icons = {
            discharging = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          };
          #format-time = "{H}:{m}";
          format-full = "󰂄";
          format-plugged = "󱐋"; #󰂄"; #";
          format-critical = "󱃍";
          interval = 30;
          states = {
            notice = 25;
            warning = 15;
            critical = 7;
          };
          tooltip = true;
          tooltip-format = "{capacity}%\t\t{power:.1f}W\n{timeTo}";
          tooltip-format-charging = "Charging [{capacity}%]\n{power:.1f}W\n{time} to full";
          tooltip-format-discharging = "{capacity}% Using {power:.1f}W\n{time} remaining";
          tooltip-format-full = "Full {power:.1f}W";
          tooltip-format-plugged = "Plugged in {power:.1f}W";
          # on-click = "2";
        };
        "network#vpn" = {
          interface = "tailscale0";
          format = "{icon}";
          format-icons = {
            ethernet = [""];
            linked = [""];
            inactive = [""];
            disconnected = [""];
          };
        };
        "network" = {
          # interface = "wlp1s0";
          # format = "{ifname}";
          format = "{icon}";
          format-alt = "{ipaddr}/{cidr} {icon}";
          format-alt-click = "click-right";
          format-linked = "linked?{icon}";
          format-icons = {
              # wifi = ["" " " " "];
              wifi = [" "];
              ethernet = [" "];
              linked = [" "];
              disconnected = [" "];
          };
          tooltip-format-wifi = "  {essid}\n   {frequency}GHz ({signalStrength}%)\n   {ipaddr}";
          tooltip-format-ethernet = "  {ifname}\n   {ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          tooltip-format = "{ipaddr}\n{ifname} via {gwaddr}";
          max-length = 50;
          on-click = "ignis toggle ignis_CONTROL_CENTER";
          #on-click = "networkmanager_dmenu";
          on-click-middle = "nm-connection-editor";
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Profile: {profile}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "󰓅";
            balanced = "󰾅";
            power-saver= "󰾆";
          };
        };
        tray = {
          #"icon-size": 21,
          spacing = 8;
        };
        "custom/hyprlock" = {
          on-click-middle = "rofi-systemd";
          format = "{icon}";
          format-icons = " ";
          tooltip = false;
          tooltip-format = "Lock Menu";
          menu = "on-click";
          menu-file = "$HOME/.config/waybar/power_menu.xml";
          menu-actions = {
            shutdown = "systemctl poweroff";
            reboot = "systemctl reboot";
            suspend = "systemctl suspend";
            hibernate = "systemctl hibernate";
            logout = "hyprctl dispatch exit";
            lock = "loginctl lock-sessions";
          };
        };
        "custom/media" = {
          format = "{icon}";
          return-type = "json";
          format-icons = {
              Paused = "";
              Playing = "";
              Stopped = "";
          };
          max-length = 70;
          exec = "playerctl -a metadata --format '{\"text\": \"{{playerName}}: {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{artist}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
        };
        mpris = {
          dynamic-len = 20;
          dynamic-separator = "   ";
          dynamic-order = ["artist"  "title"  "album"];
          player-icons = {
            #default = "▶";
            default = "";
            spotify = " ";
	    mpv = " ";
          };
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
          ignored-players = ["firefox"];
          format = "{status_icon}";
          format-stopped = "";
          tooltip-format-playing = " {player_icon}\n{dynamic}";
          tooltip-format-paused = " {player_icon}\n{dynamic}";
          tooltip-format-stopped = "";
        };
        "custom/agenda" = {
          format = "{}";
          exec = "env GCALCLI_DEFAULT_CALENDAR=Wassup nextmeeting --max-title-length 30 --waybar";
          on-click = "env GCALCLI_DEFAULT_CALENDAR=Wassup nextmeeting --open-meet-url";
          on-click-right = "kitty -- /bin/bash -c \"batz;echo;cal -3;echo;nextmeeting;read;\";";
          interval = 59;
          return-type = "json";
          tooltip = true;
          };
        clock = {
          locale = "en_IE.UTF-8";
          format = "{:%H:%M}"; # ";
          format-alt = "{:L%A %R %Z}"; #  ";
          #format-alt = "{:%a %d %b %Y - %R %Z}  ";
          #tooltip-format = "<tt><small>{calendar}</small></tt>";
          tooltip-format = "{:L%A\n%d %B %Y\n%R %Z\nWeek %V}"; #\n{tz_list}";
        };
        "custom/leftend" = {
          format = "";
        };
      };
    };
    programs.waybar.style = ./style.css;
    xdg.configFile."waybar/power_menu.xml".source = ./power_menu.xml;
  };
}
