{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    services.cliphist = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      extraOptions = [
        "-max-items"
        "50"
        "-db-path"
        "/run/user/%U/cliphist/db"
      ];
    };
  };
}
