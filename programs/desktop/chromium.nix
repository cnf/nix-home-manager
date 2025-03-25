{ lib, config, ... }:

{
  options = {
    my.chromium.enable = lib.mkEnableOption "Enable and configure chromium";
  };
  config = lib.mkIf config.my.chromium.enable {
    home.sessionVariables = {
    };
    programs.chromium.enable = true;
  };
}
