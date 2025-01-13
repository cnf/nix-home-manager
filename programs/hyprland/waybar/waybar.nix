{ pkgs, lib, config, inputs, unstable, ... }:
let
  commonDeps = with pkgs; [coreutils gnugrep systemd];
  mkScript = {
    name ? "script",
    deps ? [],
    script ? "",
  }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });
in
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      waybar-mpris
    ];
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
        ];
        modules-right = [
          #"group/privacywarn"
          "privacy"
          "custom/webcam"

          "idle_inhibitor"
          "group/hardware"
          #"mpris"
          "custom/media"
          "pulseaudio"
          "pulseaudio/slider"
          "battery"
          #"network"

          "tray"
          "custom/hyprlock"

          "clock"
        ];
        "custom/launcher" = {
          on-click = "rofi -show drun";
          on-click-right = "hyprsysteminfo";
          format = " ";
          #format = "";
          # format = " ";
          tooltip = true;
          tooltip-format = "Launch Applications";
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = false;
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
          exec = mkScript {
            name = "webcam-usage";
            deps = [pkgs.jq pkgs.psmisc];
            script = ''
              fuser /dev/video* 2>/dev/null|xargs -r ps --no-headers -eo pid,comm -q \
              | sed 's/\.\(.*\)-wra\?p\?p\?e\?d\?/\1/g' \
              | awk '{print "{\"tooltip\": \"" $NF " " "["$1"]" "\"}"}' \
              | jq -s 'if length > 0 then {text: "󰖠", tooltip: (map(.tooltip) | join("\r"))} else {text: "󱜷", tooltip: "No applications are using your webcam!"} end' \
              | jq --unbuffered --compact-output
            '';
          };
        };
        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-left-to-right = false;
          };
          modules = [
            "power-profiles-daemon"
            "memory"
            "cpu"
            "temperature"
          ];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        pulseaudio = {
          #scroll-step": 1, // %, can be a float
          format = "{icon}";
          format-muted = "󰝟";
          format-bluetooth = "{icon}";
          format-bluetooth-muted = "{icon}";
          format-source = "";
          format-source-muted = " ";
          format-icons = {
              headphone = "󱡏 ";
              headphone-muted = "󱡐 ";
              hdmi = "󰡁";
              hifi = "󰓃";
              hifi-muted = "󰓄";
              #speaker = ["" "" "" " " " "];
              speaker = ["󰕿" "󰖀" "󰖀" "󰕾" "󰕾"];
              speaker-muted = "󰝟"; #"󰖁 ";
              hands-free = " ";
              headset = " ";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" "" " " " "];
          };
          tooltip-format = "{icon} {volume:3}% {desc}\n{format_source} {source_volume:3}% {source_desc}";
          on-click = "pavucontrol";
          on-click-right = "rofi-pulse-select sink";
          on-click-middle = "rofi-pulse-select source";
          reverse-scrolling = true;
        };
        bluetooth = {
          icon-size = 14;
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "";
          format-no-controller = "";
          interval = 30;
          on-click = "blueman-manager";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          # format-device-preference= [ "device1", "device2" ]; # preference list deciding the displayed device
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip-format-activated = "Inhibiting Idle";
          tooltip-format-deactivated = "Free to idle";
        };
        cpu = {
          interval = 10;
          format = "{icon}";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          max-length = 10;
          # tooltip-format = "{load} {max_frequency}GHz {usage}%";
        };
        memory = {
          interval = 30;
          format = "{}%  ";
          max-length= 10;
          tooltip-format = "{used:0.1f}G/{total:0.1f}G  ";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        temperature = {
          format = "{icon}";
          format-critical = "{temperatureC}°C {icon}";
          hwmon-path = [
            "/sys/class/hwmon/hwmon5/temp1_input" # CPU
            "/sys/class/hwmon/hwmon0/temp1_input" # GPU
          ];
          critical-threshold = 85;
          format-icons = ["" "" "" "" ""];
          tooltip-format = "{temperatureC}°C ";
          tooltip = true;
          # tooltip-format = "GPU : {temperatureC}°C {icon}";
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
              warning = 25;
              critical = 10;
          };
          tooltip = true;
          tooltip-format = "{capacity}%\t\t{power:.1f}W\n{timeTo}";
          tooltip-format-charging = "Charging [{capacity}%]\n{power:.1f}W\n{time} to full";
          tooltip-format-discharging = "Using {power:.1f}W\n{time} remaining";
          tooltip-format-full = "Full {power:.1f}W";
          tooltip-format-plugged = "Plugged in {power:.1f}W";
          # on-click = "2";
        };
        "network#wg" = {
          interface = "wg0";
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
          format-linked = "linked?";
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
          # on-click = "networkmanager_dmenu";
          on-click = "nm-connection-editor";
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
          on-click-right = "rofi -show power-menu -modi power-menu:rofi-power-menu";
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
              paused = "";
              playing = "";
              stopped = "";
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
          player-icons = {
            default = "▶";
            spotify = "";
	    mpv = "";
          };
          status-icons = {
            playing = "";
            paused = "";
            stopped = "";
          };
          ignored-players = ["firefox"];
          format = "{player_icon}  {status_icon}";
          format-stopped = "";
          tooltip-format = "{player_icon}  {player}  {status_icon}\n{dynamic}";
        };
        clock = {
          locale = "en_IE.UTF-8";
          format = "{:%H:%M}  ";
          format-alt = "{:L%A %R %Z}  ";
          #format-alt = "{:%a %d %b %Y - %R %Z}  ";
          #tooltip-format = "<tt><small>{calendar}</small></tt>";
          tooltip-format = "{:L%A\n%d %B %Y\n%R %Z\nWeek %V}"; #\n{tz_list}";
        };
      };
    };
    programs.waybar.style = ./style.css;
    xdg.configFile."waybar/power_menu.xml".source = ./power_menu.xml;
  };
}
