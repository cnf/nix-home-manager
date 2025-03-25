{ unstable, lib, config, ... }:
{
  options = { 
    my.discord.enable = lib.mkEnableOption "Install Discord";
  };
  config = lib.mkIf config.my.discord.enable {
    home.packages = [
      unstable.discord
      unstable.dissent
      #webcord
      #legcord
    ];
  };
}
