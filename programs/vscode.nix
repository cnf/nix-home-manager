{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    myVSCode.enable = lib.mkEnableOption "Enable VSCode";
  };
  config = lib.mkIf config.myVSCode.enable {
    programs.vscode = {
    enable = true;
  };
  };
}
