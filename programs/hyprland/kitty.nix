{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [kitty-img];
    programs.kitty = {
      enable = true;
      font.name = "family=\"Source Code Pro\"";
      font.size = 12;
      settings = {
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        tab_bar_edge = "top";
        tab_bar_style = "slant";
        #active_tab_foreground = "#FF6700";
        active_tab_background = "#FF6700";
        active_tab_font_style = "bold-italic";
        #inactive_tab_foreground = "#0098FF";
        inactive_tab_background = "#0098FF";
        inactive_tab_font_style = "normal";
        enable_audio_bell = false;
        visual_bell_duration = "0.4 ease-in-out linear";
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt"; 
        "ctrl+v" = "paste_from_clipboard";
      };
    };

  };
}
