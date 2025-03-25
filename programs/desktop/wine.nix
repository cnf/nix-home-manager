{ pkgs, lib, config, unstable, ... }:
{
  options = { 
    my.wine.enable = lib.mkEnableOption "Install wine";
  };
  config = lib.mkIf config.my.wine.enable {
    home.packages = [
      pkgs.wineWowPackages.unstableFull
      #pkgs.wine
      pkgs.bottles
      pkgs.winetricks
    ];
  };
}
