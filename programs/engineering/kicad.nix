{ pkgs, unstable, lib, config, inputs, outputs, ... }:
let
    kicad = (
      pkgs.kicad.overrideAttrs ( finalAttrs: prevAttrs: {
        makeWrapperArgs = prevAttrs.makeWrapperArgs ++ [
          " --set JAVA_HOME ${pkgs.temurin-jre-bin}"
          " --set JAVA_OPTIONS -Dawt.useSystemAAFontSettings=on"
          ];
      })
    ).override {
      addons = with pkgs.kicadAddons; [ kikit kikit-library ];
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
}
