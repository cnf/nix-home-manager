{ pkgs, unstable, lib, config, ... }:
{
  options = { 
    my.davinci.enable = lib.mkEnableOption "Install DaVinci Resolve";
  };
  config = lib.mkIf config.my.davinci.enable {
    home.packages = [
      unstable.davinci-resolve
    ];
  };
}
