{ pkgs, unstable, lib, config, ... }:
{
  options = {
    my.helpers.enable = lib.mkEnableOption "Various helper scripts";
  };
  config = lib.mkIf config.my.helpers.enable {
    #nixpkgs.config.allowUnfreePredicate = pkg: 
    #  builtins.elem (lib.getName pkg) ["gitkraken"];

    home.packages = with pkgs; [
    ];
  };
}
