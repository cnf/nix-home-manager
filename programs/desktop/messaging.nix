{ unstable, pkgs, lib, config, ... }:
{
  options = { 
    my.messaging.enable = lib.mkEnableOption "Install messaging apps";
  };
  config = lib.mkIf config.my.messaging.enable {

    home.packages = [
      pkgs.signal-desktop
    ];
  };
}
