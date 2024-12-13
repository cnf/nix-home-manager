{ pkgs, lib, config, inputs, unstable, system, ... }:

{
  imports = [
    inputs.hypr-binds.homeManagerModules.x86_64-linux.default
  ];
  config = lib.mkIf config.my.hyprland.enable {
    programs.hypr-binds = {
      enable = true;
      settings = {
        launcher = {
          app = "rofi";
          style = {
            modkey = "<b>$MOD$KEY</b> <i>$DESCRIPTION</i>";
            command = "#6e6e7e";
          };
        };
        dispatch = true;
      };
    };
  };
}
