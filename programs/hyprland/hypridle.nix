{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      unstable.hypridle
      brightnessctl
    ];
    home.file.".config/hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
        unlock_cmd = pkill -USR1 hyprlock      # same as above, but unlock
        before_sleep_cmd = notify-send "Zzz"    # command ran before sleep
        after_sleep_cmd = notify-send "Awake!"  # command ran after sleep
        ignore_dbus_inhibit = false             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
        ignore_systemd_inhibit = false          # whether to ignore systemd-inhibit --what=idle inhibitors
      }
      listener {
        timeout = 150                                # 2.5min.
        on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = brightnessctl -r                 # monitor backlight restore.
      }
      listener {
        timeout = 500                            # in seconds
        on-timeout = loginctl lock-session
      }
      listener {
        timeout = 1000                                # 2.5min.
        on-timeout = hyprctl dispatch dpms off         # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = hyprctl dispatch dpms on                 # monitor backlight restore.
      }
    '';
  };
}