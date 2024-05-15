{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    #home.packages = with pkgs; [
    #  swayosd
    #  wob
    #];
    #services.swayosd.enable = false;
    #services.wob.enable = true;
  };
}
