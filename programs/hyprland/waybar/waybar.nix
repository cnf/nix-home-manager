{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    programs.waybar.enable = true;
    programs.waybar.package = inputs.waybar.packages.${pkgs.system}.default;
    programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 30;
      # spacing = 4;
      modules-left = [
        "custom/launcher"
        #"wlr/taskbar"
        "hyprland/submap"
        "hyprland/window"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "weather"
        "idle_inhibitor"
        "pulseaudio"
        "bluetooth"
        "network"
        "power-profiles-daemon"
        "privacy"
        "battery"

        "custom/separator"
        "tray"
        "custom/separator"
        "custom/hyprlock"
        "clock"
      ];
      "custom/launcher" = {
        on-click = "rofi -show drun";
        format = "";
        tooltip = true;
        tooltip-format = "Launch Applications";
      };
      "wlr/taskbar" = {
        format = "{icon}";
        # icon-size = 18;
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
        active-first = true;
        ignore-list = [
           "Alacritty"
        ];
        app_ids-mapping = {
            "firefoxdeveloperedition" = "firefox-developer-edition";
            "kittyfloat" = "kitty";
        };
        rewrite = {
            "Firefox Web Browser" = "Firefox";
            "Foot Server" = "Terminal";
        };
      };
      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = false;
        format = "{icon}";
        format-icons = {
	  "1" = "";
          "2" = "";
	  "3" = "";
	  "4" = "";
          urgent = "";
          #active = "";
          # active = "";
          #default = "";
        };
        on-click = "activate";
        persistent-workspaces = {
          "*" = 4;
        };
      };
      "hyprland/submap" = {
        format = " {} ";#
        max-length = 20;
        tooltip = false;
      };
      "hyprland/window" = {
        format = "{}";
        rewrite = {
          "(.*) — Mozilla Firefox" = "  $1  ";
          "(.*) - fish" = "> [$1]";
        };
        # separate-outputs = true;
      };
      clock = {
        format = "{:%a %e %b  %H:%M}";
        tooltip = true;
        tooltip-format = "{: %A, %B %e %Y}";
      };
      pulseaudio = {
        #scroll-step": 1, // %, can be a float
        format = "{volume}% {icon}";
        # format = "{icon} {volume}%";
        format-bluetooth = "{volume}%  {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [" " " " " "];
        };
        on-click = "pavucontrol";
      };
      bluetooth = {
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

      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      network = {
        #"interface": "wlp2s0",
        # format = "{ifname}";
        format = "{icon}";
        format-alt = "{ipaddr}/{cidr} {icon}";
        format-alt-click = "click-right";
        format-icons = {
            wifi = ["" "" ""];
            ethernet = [""];
            disconnected = ["󰖪"];
        };
        tooltip-format = "{ifname} via {gwaddr} 󰊗";
        tooltip-format-wifi = "{essid} ({signalStrength}%)  {frequency}";
        tooltip-format-ethernet = "{ipaddr}/{cidr}  {ifname}";
        tooltip-format-disconnected = "Disconnected";
        max-length = 50;
        on-click = "nm-connection-editor";
      };
      "tray" = {
        #"icon-size": 21,
        spacing = 10;
      };
      "custom/hyprlock" = {
        on-click = "nwg-bar";
        format = "{icon}";
        format-icons = "  ";
        tooltip = true;
        tooltip-format = "Lock Menu";
      };
      "custom/separator" = {
        format = "|";
        tooltip = false;
      };
    };
    };
    programs.waybar.style = ./style.css;
  };
}
