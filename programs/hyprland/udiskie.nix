{ pkgs, lib, config, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    services.udiskie = {
      enable = true;
      tray = "auto";
      settings = {
         terminal = "kitty";
      };
      device_config = {
      };
    };
    home.packages = with pkgs; [
      ntfs-3g
    ];
  };
}
