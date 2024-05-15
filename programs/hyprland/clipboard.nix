{ pkgs, lib, config, inputs, unstable, ... }:

{
  #options = {
  #  my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
  #};
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    services.cliphist.enable = true;
  };
}
