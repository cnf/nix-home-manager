{ pkgs, lib, config, inputs, unstable, ... }:
{
  config = lib.mkIf config.my.hyprland.enable {
    # home.packages = with pkgs; [
    #   # hyprpaper
    # ];
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = [ 
          "${config.home.homeDirectory}/.wallpaper.jpg"
        ];

        wallpaper = [
          ", ${config.home.homeDirectory}/.wallpaper.jpg" #format is "Monitor, file" or ",/path/file" or all monitorss
        ];
      };
    };
  };
}
