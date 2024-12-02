{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.vscode.enable = lib.mkEnableOption "Enable VSCode";
  };
  config = lib.mkIf config.my.vscode.enable {
    programs.vscode = {
    enable = true;
  };
  };
}
