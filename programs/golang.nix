{ pkgs, lib, config, inputs, ... }:
{
  options = {
    myGolang.enable = lib.mkEnableOption "Enable and configure golang";
  };
  config = lib.mkIf config.myGolang.enable {
    programs.go = {
      enable = true;
    };
  };
}
