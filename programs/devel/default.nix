{ pkgs, lib, config, inputs, ... }:
{
  imports = [
  ];

  programs.direnv.enable = true;
  home.packages = with pkgs; [
  ];
}
