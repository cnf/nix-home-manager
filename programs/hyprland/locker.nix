{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      nwg-bar
    ];
    programs.wlogout.enable = false;
    programs.wlogout.layout = [
      { 
        label = "lock";
        action = "hyprlock";
        text = "Lock";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
      }
    ];
    #programs.wlogout.style = ''
    #  window {
    #    background: #16191C;
    #  }
    #
    #  button {
    #    color: #AAB2BF;
    #  }
    #'';
    home.file.".config/nwg-bar/bar.json".text = ''
      [
 {
   "label": "Lock",
   "exec": "hyprlock",
   "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-lock-screen.svg"
 },
 {
   "label": "Logout",
   "exec": "hyprctl dispatch exit",
   "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-log-out.svg"
 },
 {
   "label": "Reboot",
   "exec": "systemctl reboot",
   "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-reboot.svg"
 },
 {
   "label": "Shutdown",
   "exec": "systemctl -i poweroff",
   "icon": "${pkgs.nwg-bar}/share/nwg-bar/images/system-shutdown.svg"
 }
]
    '';
  };
}
