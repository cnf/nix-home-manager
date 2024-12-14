{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.golang.enable = lib.mkEnableOption "Enable and configure golang";
  };
  config = lib.mkIf config.my.golang.enable {
    programs.go = {
      enable = true;
      goPath = "${config.xdg.dataHome}";
      packages = {};
    };
  };
}
