{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.my.funshoot.enable {

    my.mqtt.enable = lib.mkDefault true;
    home.packages = with pkgs; [
      #qlcplus
    ];

  };
}
