{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.yubikey.enable = lib.mkEnableOption "Install yubikey tools";
  };
  config = lib.mkIf config.my.yubikey.enable {
    home.packages = with pkgs; [
      yubioath-flutter
      yubico-piv-tool
    ];
  };
}
