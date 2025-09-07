{ lib, config, pkgs, inputs, ... }:
let
  my-ignis = inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.ignis.override {
    #buildInputs = prev.buildInputs ++ [
    extraPackages = [
      pkgs.python312Packages.jinja2
      pkgs.python312Packages.pillow
      pkgs.python312Packages.materialyoucolor
      pkgs.python312Packages.humanize
      pkgs.python312Packages.psutil
    ];
  };

in
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = [
      #my-ignis
    ];
#    systemd.user.services.ignis = {
#      Unit = {
#        Description = "Ignis widgets";
#        #Requires = "hyprland-session.target";
#        After = "graphical-session-pre.target";
#        PartOf = "graphical-session.target";
#      };
#      Service = {
#        ExecStart = "${lib.getExe my-ignis} init";
#        Restart = "on-failure";
#        Type = "simple";
#        #ConditionEnvironment = ["XDG_RUNTIME_DIR" "WAYLAND_DISPLAY" "DBUS_SESSION_BUS_ADDRESS" ];
#      };
#      Install = {
#        WantedBy = [ "hyprland-session.target" ];
#      };
#    };
#
  };
}
