{ pkgs, lib, config, ... }:

{
  options = {
    my.kitty.enable = lib.mkEnableOption "Enable and configure Kitty";
  };
  config = lib.mkIf config.my.kitty.enable {
    home.packages = with pkgs; [
      kitty-img
      # nautilus-open-any-terminal
    ];
    programs.kitty = {
      enable = true;
      font.name = "family=\"SauceCodePro Nerd Font\"";
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
        window_padding_width = 5;
        scrollback_pager_history_size = 250;
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt"; 
        "ctrl+v" = "paste_from_clipboard";
        "ctrl+," = "edit_config_file";
      };
    };
    #xdg.configFile."kitty/ssh.conf" = {
    #  enable = true;
    #  text = ''
    #    env PS1="(REMOTE) $PS1"
    #    env _TEST_VAR=hello
    #  '';
    #};
  };
}
