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
          # "bluetooth"
          # "network"

          #"custom/separator"
          "tray"
          #"custom/separator"
          "custom/hyprlock"
          "clock"
        ];
        "custom/launcher" = {
          on-click = "rofi -show drun";
          #format = " ";
          #format = "";
          format = " ";
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
            urgent = " ";
            #urgent = " ";
            #active = " ";
            #active = " ";
            #active = " ";
            #default = "";
          };
          on-click = "activate";
          persistent-workspaces = {
            "*" = 4;
          };
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
            "OneDriveGUI (.*)" = "󰏊 $1";
          };
          separate-outputs = true;
        };
        privacy = {
          icon-size = 14;
        };
        clock = {
          format = "{:%a %e %b  %H:%M}";
          tooltip = true;
          #tooltip-format = "{: %A, %B %e %Y}
          tooltip-format = "<tt><small>{calendar}</small></tt>";
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
        pulseaudio = {
          #scroll-step": 1, // %, can be a float
          format = "{icon}";
          # format = "{icon} {volume}%";
          format-bluetooth = "{volume}%  {icon} {format_source}";
          format-bluetooth-muted = "󰖁 {icon} {format_source}";
          format-muted = "󰖁  {format_source}";
          # format-muted = "<span font='Font Awesome 5 Free 11'></span>";
          format-source = ""; # input
          format-source-muted = ""; #input
          format-icons = {
              #headphone = " ";
              headphone = [" " " " " " " "];
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["󰕿" "󰖀" "󰕾"];
              # default = ["" " " " "];
          };
          tooltip-format = "{volume}% {icon} | {format_source}";
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
        };
        cpu = {
          interval = 10;
          format = "{}% ";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          max-length = 10;
        };
        memory = {
          interval = 30;
          format = "{}%  ";
          max-length= 10;
          tooltip-format = "{used:0.1f}G/{total:0.1f}G  ";
        };
        battery = {
          full-at = 80;
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
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          format = "{icon}";
          format-icons = "  ";
          tooltip = true;
          tooltip-format = "Lock Menu";
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
              "Playing" = "";
              "Paused" = "";
          };
          "max-length" = 70;
          "exec" = "playerctl -a metadata --format '{\"text\": \"{{playerName}}: {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{artist}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click" = "playerctl play-pause";
          "on-click-right" = "playerctl next";
          "on-click-middle" = "playerctl previous";
      };
      };
    };
    programs.waybar.style = ./style.css;
  };
}
