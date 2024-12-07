{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    # home.packages = with pkgs; [
    #   hyprpaper
    # ];
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = [ 
          "/home/cnf/wallpaper.jpg"
        ];

        wallpaper = [
          ", /home/cnf/wallpaper.jpg"
          #"DP-3,/share/wallpapers/buttons.png"
          #"DP-1,/share/wallpapers/cat_pacman.png"
        ];
      };
    };
  };
}
