{ inputs, ... }:
{
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];
  programs.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
      layerrules = true;
      windows = {
        scale = 7.5;
        items_per_row = 5;
        switch = {
          enable = true;
          modifier = "alt";
          #show_workspaces = true;
        };
        overview = {
          key = "tab";
          modifier = "super";
          launcher = {
            default_terminal = "kitty";
            #enable = true;
            # key = "super+space";
            launch_modifier = "ctrl";
            plugins.calc.enable = true;
            plugins.applications.enable = true;
            plugins.shell.enable = true;
            plugins.terminal.enable = true;
            width = 650;
            plugins.websearch.enable = true;
          };
        };
      };
    };
    styleFile = ./hyprshell.css;
  };
}
