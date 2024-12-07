{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    services.cliphist.enable = true;
  };
}
