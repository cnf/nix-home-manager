{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.discord.enable = lib.mkEnableOption "Install Discord";
  };
  config = lib.mkIf config.my.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
