{ pkgs, lib, config, inputs, unstable, ... }:

{
  #imports = lib.mkIf config.my.hyperland.enable [./hyprbinds.nix];
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      #rofi-calc
      #rofi-emoji-wayland
      #rofi-games
      #rofi-screenshot
      #unstable.rofi-power-menu
      #unstable.rofi-systemd
      (unstable.rofi-systemd.override {rofi = unstable.rofi-wayland;}) # TODO: remove when fixed upstream [2025-01-19] 
      libqalculate # for rofi-calc
      unstable.pinentry-rofi
      unstable.rofi-bluetooth
      unstable.rofi-menugen
      unstable.rofi-pulse-select
    ];
    programs.rofi = {
      enable = true;
      plugins = with pkgs; [
        (rofi-calc.override { rofi-unwrapped = unstable.rofi-wayland-unwrapped; }) # TODO: remove when fixed upstream [2024-12-11]
        (rofi-games.override {rofi = unstable.rofi-wayland; }) # TODO: remove when fixed upstream [2024-12-11]
        unstable.rofi-emoji-wayland
        #pinentry-rofi
        #unstable.rofi-menugen
        #unstable.rofi-power-menu
        #rofi-pulse-select
        #rofi-screenshot
        #unstable.rofi-systemd
      ];
      pass = {
        enable = true;
      };
      package = unstable.rofi-wayland;
      terminal = "${pkgs.kitty}/bin/kitty";
      theme = "rofi.rasi";
      #font = "JetBrainsMono Nerd Font";
      #font = "Lekton Nerd Font";
      font = "sans-serif 12";
      extraConfig = {
        sidebar-mode = true;
        show-icons = true;
        icon-theme = "candy-icons";
        combi-modes = "drun,calc,ssh";
        display-drun = " ";
        display-combi = " ";
        display-calc = " ";
        display-ssh = "󰣀 ";
        display-games = "󰊗 ";
        display-emoji = " ";
        display-keys = "󰘳 ";
        display-filebrowser = " ";
        calc-error-color = "#0098ff";
        drun-show-actions = true;
        modes = [
           "drun"
           "calc"
           "ssh"
           "emoji"
           "games"
        ];
      };
    };
    #xdg.configFile."rofi/rofi.rasi".source = ./rofi.rasi;
    xdg.configFile."rofi/rofi.rasi".source = ./spotlight.rasi;
    xdg.configFile."rofi/hypr-binds".source = ./hypr-binds;
  };
}
