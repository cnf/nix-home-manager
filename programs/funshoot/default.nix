{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.funshoot.enable = lib.mkEnableOption "Install FunShoot related packages";
  };
  imports = [
    ./qlc.nix
    ./settings.nix
  ];
}
