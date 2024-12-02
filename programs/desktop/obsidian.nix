{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.obsidian.enable = lib.mkEnableOption "Install Obsidian";
  };
  config = lib.mkIf config.my.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
