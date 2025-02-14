{ pkgs, unstable, lib, config, ... }:
{
  options = { 
    my.wireshark.enable = lib.mkEnableOption "Install Wireshark";
  };
  config = lib.mkIf config.my.wireshark.enable {
    home.packages = [
      unstable.wireshark-qt
      unstable.obsidian
    ];
  };
}
