{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.eez.enable = lib.mkEnableOption "Install EEZ Studio";
  };
  config = lib.mkIf config.my.eez.enable {
    home.packages = [
      inputs.eez.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    ];
  };
}
