{ lib, config, pkgs, ... }:

{
  options = {
    my.altbrowsers.enable = lib.mkEnableOption "Enable and configure alternate browsers";
  };
  config = lib.mkIf config.my.altbrowsers.enable {
    home.sessionVariables = {
    };
    ## LibreWolf
    programs.librewolf.enable = true;
    programs.librewolf = {
      package = pkgs.librewolf-wayland;
      nativeMessagingHosts = [
        #pkgs._1password-gui
        pkgs.web-eid-app
        pkgs.fx-cast-bridge
        pkgs.ff2mpv
      ];
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          force = true;
          default = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
        };
      };
    };
  };
}
