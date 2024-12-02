{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];
    home.file = {
      ".config/hypr/hyprpaper.conf".text = ''
        preload = /home/cnf/wallpaper.jpg
        wallpaper = ,/home/cnf/wallpaper.jpg
        ipc = off
        splash = false
      '';
    };

  };
}
