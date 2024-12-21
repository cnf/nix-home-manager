{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.vscode.enable = lib.mkEnableOption "Enable VSCode";
  };
  config = lib.mkIf config.my.vscode.enable {
    programs.vscode = {
      package = unstable.vscode;
      enable = true;
    };
    home.packages = with pkgs; [
      direnv
      python3
      #gcc
      clang
    ];
  };
}
