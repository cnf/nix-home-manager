{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      waybar-mpris
    ];
    programs.waybar.enable = true;
    programs.waybar.package = inputs.waybar.packages.${pkgs.system}.waybar;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        height = 30;
        # spacing = 4;
        modules-left = [
          "custom/launcher"
          "hyprland/submap"
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "privacy"

          "idle_inhibitor"
          "custom/media"
          "group/hardware"
          "battery"
          "pulseaudio"
          "pulseaudio/slider"

          #"custom/separator"
          "tray"
          #"custom/separator"
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
          format = "{icon}";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = "󰨞 ";
            "4" = " ";
            empty = " ";
            default = " ";
            urgent = " "; #" ";
            persistent = " ";
            special = "󰺕 ";
            #urgent = " ";
            #active = " ";
            #active = " ";
            #active = " ";
            #default = "";
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
          rewrite = {
            "(.*) — Mozilla Firefox" = "  $1   ";
            "(.*) - Visual Studio Code" = "  $1  ";
            "(.*) - Discord" = "  $1  ";
            "(.*) - Obsidian v.*" = " $1";
            "(.*) - FreeCAD 1.*" = " $1";
            "OneDriveGUI (.*)" = "󰏊 $1";
          };
          separate-outputs = true;
        };
        privacy = {
          icon-size = 14;
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
          "min" = 0;
          "max" = 100;
          "orientation" = "vertical";
        };
        pulseaudio = {
          #scroll-step": 1, // %, can be a float
          format = "{icon}";
          format-muted = "󰖁 ";#   {format_source}";
          # format = "{icon} {volume}%";
          format-bluetooth = "{icon}"; # {format_source}";
          format-bluetooth-muted = "{icon}"; # {format_source}";
          format-source = ""; # input
          format-source-muted = " "; #input
          format-icons = {
              headphone = "󱡏 ";
              headphone-muted = "󱡐 ";
              hdmi = "󰡁";
              hifi = "󰓃 ";
              hifi-muted = "󰓄";
              speaker = [" " " " " " " " " "];
              speaker-muted = "󰖁 ";
              hands-free = " ";
              headset = " ";
              phone = "";
              portable = "";
              car = "";
              #default = ["󰕿 " "󰖀 " "󰕾 "];
              default = [" " " " " "];
          };
          tooltip-format = "{volume}% {icon} | {format_source}\n{desc}";
          on-click = "pavucontrol";
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
          full-at = 99;
          format = "{icon}";
          format-icons = {
            discharging = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          };
          format-time = "{H}h{M}m";
          # format-charging = "<span font='Font Awesome 5 Free'></span><span font='Font Awesome 5 Free 11'>{icon}</span>";
          format-full = "󰁹"; #<span font='Font Awesome 5 Free 11'>{icon}</span>";
          format-plugged = "";
          interval = 30;
          states = {
              warning = 25;
              critical = 10;
          };
          tooltip = true;
          tooltip-format = "{capacity}%\n{timeTo}";
          # on-click = "2";
        };
        network = {
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
          tooltip-format-wifi = "{essid} ({signalStrength}%)   \n{tooltip-format}";
          tooltip-format-ethernet = "{ipaddr}/{cidr}  {ifname}";
          tooltip-format-disconnected = "Disconnected";
          tooltip-format = "{ifname} via {gwaddr} 󰊗 ";
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
            performance = "󰓅";#"";
            balanced = "󰾅";#" ";
            power-saver= "󰾆";#"";
          };
        };
        tray = {
          #"icon-size": 21,
          spacing = 8;
        };
        "custom/hyprlock" = {
          on-click-right = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          format = "{icon}";
          format-icons = "  ";
          tooltip = false;
          tooltip-format = "Lock Menu";
          menu = "on-click";
          menu-file = "$HOME/.config/waybar/power_menu.xml";
          menu-actions = {
            shutdown = "systemctl shutdown";
            reboot = "systemctl reboot";
            suspend = "systemctl suspend";
            hibernate = "systemctl hibernate";
            logout = "loginctl terminate-session $XDG_SESSION_ID";
            lock = "loginctl lock-sessions";
          };
        };
        "custom/separator" = {
          format = ":";
          tooltip = false;
        };
        "custom/leftend" = {
          format = "";
          tooltip = false;
        };
        "custom/media" = {
          "format" = "{icon}";
          "return-type" = "json";
          "format-icons" = {
              "Paused" = "";
              "Playing" = "";
          };
          "max-length" = 70;
          "exec" = "playerctl -a metadata --format '{\"text\": \"{{playerName}}: {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{artist}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click" = "playerctl play-pause";
          "on-click-right" = "playerctl next";
          "on-click-middle" = "playerctl previous";
      };
      clock = {
        format = "{:%H:%M}  ";
        format-alt = "{:%a %d %b %Y - %R}  ";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months =     "<span color='#ffead3'><b>{}</b></span>";
            days =       "<span color='#ecc6d9'><b>{}</b></span>";
            weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
            today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions =  {
          on-click-right = "mode";
          on-click-middle = "shift_reset";
          # on-scroll-up = "tz_up";
          # on-scroll-down = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
    };
    };
    programs.waybar.style = ./style.css;
    xdg.configFile."waybar/power_menu.xml".source = ./power_menu.xml;
  };
}
