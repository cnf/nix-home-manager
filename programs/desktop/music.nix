{ unstable, pkgs, lib, config, ... }:
{
  options = { 
    my.music.enable = lib.mkEnableOption "Install music apps";
  };
  config = lib.mkIf config.my.music.enable {

    home.packages = [
      unstable.spotify
      unstable.my-sendspin
    ];
    #programs.firejail.wrappedBinaries = {
    #  plexamp = {
    #    executable = "${lib.getBin unstable.plexamp}/bin/plexamp";
    #    profile = "~/.config/firejail/plexamp.profile";
    #  };
    #};
  };
}
