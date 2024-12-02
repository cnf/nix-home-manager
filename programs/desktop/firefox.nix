{ pkgs, lib, config, inputs, ... }:

{
  options = {
    my.firefox.enable = lib.mkEnableOption "Enable and configure firefox";
  };
  config = lib.mkIf config.my.firefox.enable {
    programs.firefox = {
      profiles.default.bookmarks = {
        name = "HackRF Software Support";
        url = "https://hackrf.readthedocs.io/en/latest/software_support.html";
      };
    };
  };
}
