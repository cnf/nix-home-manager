{ pkgs, lib, config, inputs, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    home.packages = with pkgs; [
      pdf-sign
      pdf-parser
      pdfmixtool
    ];
  };
}
