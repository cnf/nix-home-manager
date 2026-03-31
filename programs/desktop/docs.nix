{ lib, config, pkgs, ... }:

{
  #options = {
  #  my.chromium.enable = lib.mkEnableOption "Enable and configure chromium";
  #};
  config = lib.mkIf config.my.desktop.enable {
    home.sessionVariables = {
    };
    home.packages = with pkgs;[
      texlive.combined.scheme-small
      glabels-qt
    ];
    programs.pandoc = {
      enable = true;
      defaults = {
        metadata = {
          author = "Frank Rosquin";
        };
        #pdf-engine = "xelatex";
        citeproc = true;
      };
    };
  };
}
