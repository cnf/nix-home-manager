{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.tryouts.enable = lib.mkEnableOption "Things I am trying out";
  };
  config = lib.mkIf config.my.tryouts.enable {

    home.packages = with pkgs; [
      graphia
    ];
  };
}
