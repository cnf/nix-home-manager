{ pkgs, lib, config, inputs, unstable, ... }:

{
  # TODO: probably remove this
  config = lib.mkIf config.my.hyprland.enable {
    services.kanshi.enable = false;
  };
}
