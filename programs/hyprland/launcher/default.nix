{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      pinentry-rofi
      libqalculate # for rofi-calc
      rofi-menugen
      rofi-emoji-wayland
      pinentry-rofi
      rofi-emoji-wayland
      rofi-power-menu
      rofi-screenshot
      rofi-calc
      rofi-games
      rofi-systemd
      rofi-pulse-select
    ];
    programs.rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-menugen
        rofi-emoji-wayland
        pinentry-rofi
        rofi-emoji-wayland
        rofi-power-menu
        rofi-screenshot
        (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; }) # TODO: remove when fixed upstream [2024-12-11]
        (rofi-games.override {rofi = rofi-wayland; }) # TODO: remove when fixed upstream [2024-12-11]
        rofi-systemd
        rofi-pulse-select
      ];
      pass = {
        enable = true;
      };
      package = pkgs.rofi-wayland;
      terminal = "${pkgs.kitty}/bin/kitty";
      theme = "rofi.rasi";
      font = "JetBrainsMono Nerd Font";
      extraConfig = {
        sidebar-mode = true;
        show-icons = true;
        icon-theme = "candy-icons";
        display-drun = "  ";
         modes = [
           "calc"
           "drun"
           "window"
           "ssh"
           "emoji"
         ];
      };
    };
    xdg.configFile."rofi/rofi.rasi".source = ./rofi.rasi;
    #xdg.configFile."rofi/hypr-binds".source = ./hypr-binds;
  };
}
