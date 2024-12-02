{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.sdr.enable = lib.mkEnableOption "Install SDR packages";
    my.hackrf.enable = lib.mkEnableOption "Install HackRF";
  };
  imports = [
    ./sdr.nix
    ./clitools.nix
  ];
}
