{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.tryouts.enable = lib.mkEnableOption "Things I am trying out";
  };
  config = lib.mkIf config.my.tryouts.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: 
      builtins.elem (lib.getName pkg) ["gitkraken"];

    home.packages = with pkgs; [
      inputs.claude-desktop.packages.x86_64-linux.default
      claude-code
      #graphia # FIXME: redo
      unstable.gitkraken
      unstable.gk-cli

      unstable.my-uv5r-ble-relay


      rdap # new whois

      imapsync

      #onlyoffice-bin


      git-backup-go
      github-backup
      git-stack
      git-gone

      warp # send or receive files
      gnome-boxes

      waypipe
      cheese # webcam

      dnsperf
      #miraclecast

      #nbted


      #unstable.synology-drive-client

      #uxplay
      #gst_all_1.gstreamer
      #gst_all_1.gst-plugins-base
      #gst_all_1.gst-vaapi
      #gst_all_1.gst-plugins-good
      #gst_all_1.gst-libav

      # WIFI
      macchanger
      kismet
    ];
  };
}
