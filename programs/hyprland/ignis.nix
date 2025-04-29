{ lib, config, pkgs, inputs, ... }:
let
  ignis = inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.ignis.overrideAttrs (final: prev: {
    buildInputs = prev.buildInputs ++ [
      pkgs.python312Packages.jinja2
      pkgs.python312Packages.pillow
      pkgs.python312Packages.materialyoucolor
      pkgs.python312Packages.humanize
      pkgs.python312Packages.psutil
    ];
  });

in
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = [
      ignis
    ];
    #systemd.user.services.ignis = {
    #  Unit = {
    #    Description = "Ignis widgets";
    #    ConditionEnvironment = ["WAYLAND_DISPLAY" "DBUS_SESSION_BUS_ADDRESS" ];
    #    #Requires = "hyprland-session.target";
    #    After = "graphical-session-pre.target";
    #    PartOf = "graphical-session.target";
    #  };
    #  Service = {
    #    ExecStart = "${lib.getExe ignis} init";
    #    Restart = "on-failure";
    #    Type = "simple";
    #    #Environment = [
    #    #  "XDG_RUNTIME_DIR=/run/user/%U"
    #    #  "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus"
    #    #];
    #  };
    #  Install = {
    #    WantedBy = [ "hyprland-session.target" ];
    #  };
    #};

  };
}
