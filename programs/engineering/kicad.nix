{ pkgs, unstable, lib, config, ... }:
let
    kicad = (
      unstable.kicad.overrideAttrs ( finalAttrs: prevAttrs: {
        makeWrapperArgs = prevAttrs.makeWrapperArgs ++ [
          " --set JAVA_HOME ${pkgs.temurin-jre-bin}"
          " --set JAVA_OPTIONS -Dawt.useSystemAAFontSettings=on"
          ];
      })
    ).override {
      addons = with unstable.kicadAddons; [ kikit kikit-library ];
    };
in
{
  config = lib.mkIf config.my.engineering.enable {
    home.packages = with pkgs; [
      temurin-jre-bin
      kicad
      # unstable.my-freerouting # don't need it separate, the plugin has the jar
    ];
  };
  # add https://raw.githubusercontent.com/kevontheweb/tokyo-night-kicad-theme/refs/heads/main/colors/tokyonight.json
}
