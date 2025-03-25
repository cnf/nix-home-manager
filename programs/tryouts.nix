{ pkgs, unstable, lib, config, ... }:
{
  options = {
    my.tryouts.enable = lib.mkEnableOption "Things I am trying out";
  };
  config = lib.mkIf config.my.tryouts.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: 
      builtins.elem (lib.getName pkg) ["gitkraken"];

    home.packages = with pkgs; [
      graphia
      unstable.gitkraken
      unstable.gk-cli

      rdap

      git-backup-go
      github-backup
      git-stack
      git-gone

      diebahn
      warp
      gnome-boxes

      owl
      opendrop

      tor-browser

      pandoc

      #unstable.synology-drive-client

      #uxplay
      #gst_all_1.gstreamer
      #gst_all_1.gst-plugins-base
      #gst_all_1.gst-vaapi
      #gst_all_1.gst-plugins-good
      #gst_all_1.gst-libav
    ];
  };
}
