{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.mqtt.enable = lib.mkEnableOption "Install MQTT stuff";
  };
  config = lib.mkIf config.my.mqtt.enable {
    home.packages = with pkgs; [
      mqttx
      mosquitto
    ];
  };
}