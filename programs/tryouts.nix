{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.tryouts.enable = lib.mkEnableOption "Things I am trying out";
  };
  config = lib.mkIf config.my.tryouts.enable {

    home.packages = with pkgs; [
      unstable.ghostty
     # ghostty.packages.${pkgs.system}.default
    ];

#    xdg.desktopEntries.SDR = {
#      name = "SDR";
#      comment = "Software Defined Radio";
#      icon = "sdr";
#      type = "Directory";
#    };
  };
}
