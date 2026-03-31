{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.obs.enable = lib.mkEnableOption "Install OBS";
  };
  config = lib.mkIf config.my.obs.enable {
    home.packages = with pkgs; [
      obs-studio
      obs-do
      obs-cmd
      obs-cli

    ];
  };
}
