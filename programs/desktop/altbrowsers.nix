{ lib, config, pkgs, unstable, ... }:

{
  options = {
    my.altbrowsers.enable = lib.mkEnableOption "Enable and configure alternate browsers";
  };
  config = lib.mkIf config.my.altbrowsers.enable {
    home.packages = [
      #unstable.opera
      unstable.chromium
    ];
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
          default = "ddg";
          order = [ "ddg" "bing" ];
        };
      };
    };
  };
}
