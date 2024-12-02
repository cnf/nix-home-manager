{ pkgs, lib, config, inputs, unstable, ... }:

{
  #options = {
  #  my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
  #};
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      hyprkeys
      pinentry-rofi
    ];
    #programs.fuzzel.enable = true;
    home.file.".config/hypr/keys.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # Format JSON proper;y
        #JSON=$(hyprkeys --from-ctl --raw)
        JSON=$(hyprkeys --from-ctl --json | jq -r --slurp "[.[]][0]");

        USER_SELECTED=$(echo $JSON | jq -r 'range(0, length) as $i | "\($i) \(.[$i].mods) \(.[$i].key) \(.[$i].dispatcher) \(.[$i].arg)"' | rofi -dmenu -p 'Keybinds' | awk -F ' ' '{print $1}')

        if [ -z "$USER_SELECTED" ]; then
          exit 0;
        fi

        EVENT=$(echo $JSON | jq -r "[.[]] | .[$USER_SELECTED]" | jq -r '"\(.dispatcher) \(.arg)"');

        hyprctl dispatch "$EVENT";
      '';
    };
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "${pkgs.kitty}/bin/kitty";
      theme = "theme.rasi";
      font = "JetBrainsMono Nerd Font";
      extraConfig = {
        show-icons = true;
        display-drun = "  ";
      };
      plugins = [
        pkgs.rofi-menugen
      ];
    };
  };
}
