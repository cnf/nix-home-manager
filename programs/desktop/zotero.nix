{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.zotero.enable = lib.mkEnableOption "Install Zotero";
  };
  config = lib.mkIf config.my.zotero.enable {
    home.packages = with pkgs; [
      zotero
    ];
  };
}
