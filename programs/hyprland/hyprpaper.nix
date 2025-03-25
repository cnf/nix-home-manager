{ pkgs, lib, config, inputs, unstable, ... }:
{
  config = lib.mkIf config.my.hyprland.enable {
    # https://www.deviantart.com/bisbiswas/art/Mountain-Lights-858303874
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
