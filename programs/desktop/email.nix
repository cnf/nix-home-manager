{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.email.enable = lib.mkEnableOption "Install email stuff";
  };
  config = lib.mkIf config.my.email.enable {
    home.packages = with pkgs; [
      mailspring
      geary
    ];
  };
}
