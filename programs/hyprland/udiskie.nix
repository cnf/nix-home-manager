{ pkgs, lib, config, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    services.udiskie = {
      enable = true;
      tray = "auto";
      settings = {
        program_options = {
          file_manager = "/run/current-system/sw/bin/xdg-open";
          menu = "flat";
        };
        terminal = "kitty";
        device_config = [
        ];
      };
    };
    #home.packages = with pkgs; [
      #ntfs3g
    #];
  };
}
