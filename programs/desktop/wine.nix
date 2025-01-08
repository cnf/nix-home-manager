{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.wine.enable = lib.mkEnableOption "Install wine";
  };
  config = lib.mkIf config.my.wine.enable {
    home.packages = with pkgs; [
      wine
      bottles
    ];
  };
}
