{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.gaming.enable = lib.mkEnableOption "Install gaming stuff";
  };
  config = lib.mkIf config.my.gaming.enable {
    home.packages = with unstable; [
      unstable.minigalaxy
      unstable.steam
      heroic
      mangohud
      protonup
      lutris
    ];
    #programs.steam.enable = true;
    #programs.steam.gamescopeSession.enable = true;
    # programs.gamemode.enable = true;

  };
}
