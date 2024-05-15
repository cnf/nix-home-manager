{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    programs.waybar.enable = true;
    programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 30;
      # spacing = 4;
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        "wlr/taskbar"
        "hyprland/submap"
        "hyprland/window"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "weather"
        "idle_inhibitor"
        "pulseaudio"
        #"network"
        #"bluetooth"
        "power-profiles-daemon"
        "privacy"
        "battery"

        "tray"
        "custom/hyprlock"
      ];
      "custom/launcher" = {
        on-click = "rofi -show drun";
        format = "";
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
          urgent = "";
          focused = "";
          active = "";
          default = "";
        };
        on-click = "activate";
        persistent-workspaces = {
          "*" = 4;
        };
      };
      "hyprland/submap" = {
        format = "✌  {}";
        max-length = 8;
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
        format = "{:%a, %e %b, %H:%M}";
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
        format = " {status}";
        format-disabled = "";
        format-off = "";
        interval = 30;
        on-click = "blueman-manager";
        format-no-controller = "";
      };

      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      "tray" = {
        #"icon-size": 21,
        spacing = 10;
      };
      "custom/hyprlock" = {
        on-click = "nwg-bar";
        format = "  ";
        tooltip = true;
        tooltip-format = "shutdown now {}";
      };
    };
    };
    programs.waybar.style = ./style.css;
  };
}
