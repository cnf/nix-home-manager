{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      hypridle
      brightnessctl
    ];
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          #lock_cmd = "pidof hyprlock || hyprlock";      # avoid starting multiple hyprlock instances.
          unlock_cmd = "pkill -USR1 hyprlock";          # same as above, but unlock
          before_sleep_cmd = "loginctl lock-session";     # command ran before sleep
          after_sleep_cmd = "hyprctl dispatch dpms on";  # command ran after sleep 
          ignore_dbus_inhibit = false;             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
          ignore_systemd_inhibit = false;          # whether to ignore systemd-inhibit --what=idle inhibitors
        };
        listener = [
          {
            timeout = 150;                              # 2.5min.
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
            on-resume = "brightnessctl -rd rgb:kbd_backlight";        # turn on keyboard backlight.
            #on-timeout = "brightnessctl -s set 0";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
            #on-resume = "brightnessctl -r";                 # monitor backlight restore.
          }
          {
            timeout = 300;                              # 2.5min.
            on-timeout = "brightnessctl -s set 0";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
            on-resume = "brightnessctl -r";                 # monitor backlight restore.
            condition_cmd = "grep -q Discharging /sys/class/power_supply/BAT1/status"; # exit 0 = run, non-zero = don't run.
            condition_retry = 30;                                   # re-check every 30s while still idle.
          }
          {
            timeout = 1700;                            # in seconds
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 1800;                                
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on"; 
          }
        ];
      };
    };
  };
}
