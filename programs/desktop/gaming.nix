{ pkgs, unstable, lib, config, ... }:
{
  options = { 
    my.gaming.enable = lib.mkEnableOption "Install gaming stuff";
  };
  config = lib.mkIf config.my.gaming.enable {
    home.packages = with pkgs; [
      unstable.minigalaxy
      unstable.steam
      #heroic
      #mangohud
      protonup-ng
      #lutris
      cartridges
    ];
    #programs.steam.enable = true;
    #programs.steam.gamescopeSession.enable = true;
    # programs.gamemode.enable = true;

  };
}
