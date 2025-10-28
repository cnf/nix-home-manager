{ pkgs, unstable, lib, config, ... }:
{
  options = { 
    my.drones.enable = lib.mkEnableOption "Drone stuff?";
  };
  config = lib.mkIf config.my.drones.enable {
    home.packages = [
      pkgs.qgroundcontrol
    ];
  };
}
