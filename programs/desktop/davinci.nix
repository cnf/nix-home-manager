{ pkgs, lib, config, ... }:
{
  options = { 
    my.davinvi.enable = lib.mkEnableOption "Install DaVinci Resolve";
  };
  config = lib.mkIf config.my.davinci.enable {
    home.packages = with pkgs; [
      unstable.davinci-resolve
    ];
  };
}
