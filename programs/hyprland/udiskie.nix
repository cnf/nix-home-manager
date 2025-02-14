{ pkgs, lib, config, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    services.udiskie = {
      enable = true;
      tray = "auto";
      settings = {
        terminal = "kitty";
        device_config = [
          { 
            id_type = "ntfs";
          }
          {
            id_uuid = [
              "usb-Samsung_SSD_960_EVO_1TB_012345678944-0:0"
            ];
          }
        ];
      };
    };
    #home.packages = with pkgs; [
      #ntfs3g
    #];
  };
}
