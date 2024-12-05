{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    # notification daemon
    programs.kitty = {
      enable = true;
      settings = {
        font_family = "family=\"Source Code Pro\"";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 12.0;
        tab_bar_edge = "top";
        tab_bar_style = "slant";
        #active_tab_foreground = "#FF6700";
        active_tab_background = "#FF6700";
        active_tab_font_style = "bold-italic";
        #inactive_tab_foreground = "#0098FF";
        inactive_tab_background = "#0098FF";
        inactive_tab_font_style = "normal";
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt"; 
        "ctrl+v" = "paste_from_clipboard";
      };
    };

  };
}
#        "col.active_border" = "rgba(ff6700ee)";
#        "col.inactive_border" = "rgba(0098ffaa)";
