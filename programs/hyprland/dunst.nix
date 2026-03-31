{ pkgs, lib, config, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    # notification daemon
    xdg.configFile."dunst/play.sh" = {
      source = ./dunst-play.sh;
      executable = true;
    };
    services.dunst.enable = true;
    services.dunst.package = unstable.dunst;
    services.dunst.settings = {
      global = {
        monitor = 0;
        dmenu = "${unstable.rofi}/bin/rofi -dmenu -p dunst";
        browser = "/run/current-system/sw/bin/xdg-open";
        mouse_left_click = "open_url,do_action,close_current";
        mouse_right_click = "close_current";
        mouse_middle_click = "close_all";
        progress_bar = true;
        sort = true;
        idle_threshold = 120;
        stack_duplicates = true;
        frame_color = "#148eff";
        frame_width = 0;
        separator_color = "frame";
        font = "${config.my.looks.font.name} ${toString config.my.looks.font.size}";
        #font-weight = "normal";
        icon_theme = "${config.my.looks.icons.name}, hicolor, candy-icons, Adwaita";
        #min_icon_size = 64;
        default_icon = "cs-notifications";
        enable_recursive_icon_lookup = true;
        corner_radius = 10;
        offset = "(15, 60)";
        origin = "top-right";
        notification_limit = 8;
        gap_size = 7;
        width = "(250, 400)";
        height = "(40, 250)";
      };
      urgency_low = {
        background = "#323232";
        foreground = "#FFFFFF";
      };

      urgency_normal = {
        background = "#323232";
        foreground = "#FFFFFF";
      };

      urgency_critical = {
        background = "#323232";
        foreground = "#FFFFFF";
        frame_color = "#ff4f44";
        timeout = 0;
      };
      # play_sound = {
      #   summary = "*";
      #   script = "/home/cnf/.config/dunst/play.sh";
      # };
      discord = {
        desktop_entry="discord";
        default_icon = "com.discordapp.Discord";
      };
      onedrive = {
        desktop_entry = "onedrive";
        default_icon = "cozydrive";
      };
      spotify = {
        desktop_entry = "spotify";
        foreground = "#888888";
      };
      #yubi-notifier = {
      #  icon = "dialog-password";
      #};
    };
  };
}
