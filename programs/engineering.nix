{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.engineering.enable = lib.mkEnableOption "Install engineering stuff";
  };
  config = lib.mkIf config.my.engineering.enable {

    #nixpkgs.overlays = [
    #  (final: prev: {
    #    serial-studio = prev.serial-studio.overrideAttrs (finalAttr: prevAttr: {
    #      version = "3.0.6";
    #      src = prev.fetchFromGitHub {
    #        owner = "Serial-Studio";
    #        repo = "Serial-Studio";
    #        rev = "v3.0.6";
    #        hash = "sha256-q3RWy3HRs5NG0skFb7PSv8jK5pI5rtbccP8j38l8kjM=";
    #        fetchSubmodules = true;
    #      };
    #    });
    #  }
    #  )
    #];

    home.packages = with pkgs; [
      prusa-slicer
      orca-slicer
      freecad-wayland
      graphviz
      kicad
      
      qFlipper
      serial-studio 
    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
