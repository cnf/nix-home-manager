{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.engineering.enable = lib.mkEnableOption "Install engineering stuff";
  };
  imports = [
    ./bulk.nix
    ./3dprinting.nix
    ./cad.nix
    ./kicad.nix
  ];

}
