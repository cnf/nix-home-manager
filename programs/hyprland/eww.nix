{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    # home.packages = with pkgs;[eww];
    # programs.eww.enable = true;
  };
}
