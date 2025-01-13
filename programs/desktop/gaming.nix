{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.gaming.enable = lib.mkEnableOption "Install gaming stuff";
  };
  config = lib.mkIf config.my.gaming.enable {
    home.packages = with pkgs; [
      unstable.minigalaxy
      unstable.steam
    ];
    #programs.steam.enable = true;
  };
}
