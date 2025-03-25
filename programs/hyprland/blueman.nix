{ pkgs, lib, config, inputs, unstable, ... }:
let
  blueman-patched = unstable.blueman.overrideAttrs (finalAttrs: previousAttrs: {
        buildInputs = previousAttrs.buildInputs ++ [unstable.procps];
  });
in
{
  config = lib.mkIf config.my.hyprland.enable {
    home.packages = [
      blueman-patched
    ];
    systemd.user.services.blueman-applet = {
      Unit = {
        Description = "Blueman applet";
        Requires = [ "tray.target" ];
        After = [ "graphical-session.target" "tray.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = { ExecStart = "${blueman-patched}/bin/blueman-applet"; };
    };
  };
}
