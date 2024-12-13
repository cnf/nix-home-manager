{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.gaming.enable = lib.mkEnableOption "Install gaming stuff";
  };
  config = lib.mkIf config.my.gaming.enable {
    home.packages = with pkgs; [
      minigalaxy
      steam
    ];
    #programs.steam.enable = true;
  };
}
