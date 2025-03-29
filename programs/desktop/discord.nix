{ unstable, pkgs, lib, config, ... }:
{
  options = { 
    my.discord.enable = lib.mkEnableOption "Install Discord";
  };
  config = lib.mkIf config.my.discord.enable {

    home.packages = [
      pkgs.discord
      #webcord
      #legcord
    ];
  };
}
