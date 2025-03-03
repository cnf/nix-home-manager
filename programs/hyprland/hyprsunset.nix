{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = with pkgs; [
      hyprsunset
    ];

    systemd.user.services.hyprsunset = {
      Unit = {
        Description = "An application to enable a blue-light filter on Hyprland.";
        Documentation = "https://wiki.hyprland.org/Hypr-Ecosystem/hyprsunset/";
        PartOf = "graphical-session.target";
        Requires = "hyprland-session.target";
        After = [ "hyprland-session.target"];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
      Service = {
        Type = "simple";
        #Slice = "session.slice";
        Restart = "on-failure";
        ExecStart = "${lib.getExe pkgs.hyprsunset}";
      };
    };
  };
}
