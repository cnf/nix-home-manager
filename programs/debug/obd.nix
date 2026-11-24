{ pkgs, unstable, lib, config, ... }:
{
  options = {
    my.obd.enable = lib.mkEnableOption "OBD / CAN / car / motorcycle stuff";
  };
  config = lib.mkIf config.my.obd.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: 
      builtins.elem (lib.getName pkg) ["obdautodoctor"];

    home.packages = with pkgs; [
      unstable.obdautodoctor
    ];
  };
}
