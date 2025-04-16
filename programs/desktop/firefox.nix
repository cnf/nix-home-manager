{ pkgs, lib, config, inputs, ... }:
{
  options = {
    my.firefox.enable = lib.mkEnableOption "Enable and configure firefox";
  };
  config = lib.mkIf config.my.firefox.enable {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      MOZ_DISABLE_RDD_SANDBOX = 1; # ?
      MOZ_USE_XINPUT2 = 1;
    };
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.web-eid-app
        pkgs.fx-cast-bridge
        pkgs.ff2mpv
      ];
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            # https://discourse.ubuntu.com/t/enabling-accelerated-video-decoding-in-firefox-on-ubuntu-21-04/22081
            # accelerated video on firefox
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
            "media.rdd-ffvpx.enabled" = false;
            "media.navigator.mediadatadecoder_vpx_enabled" = true;
            # "browser.startup.homepage" = "https://duckduckgo.com";
            "browser.search.defaultenginename" = "DuckDuckGo";
            "browser.search.order.1" = "DuckDuckGo";
            "browser.search.order.2" = "Bing";

            "signon.rememberSignons" = false;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "widget.use-xdg-desktop-portal.mime-handler" = 1;
            "widget.use-xdg-desktop-portal.settings" = 1;
            "widget.use-xdg-desktop-portal.location" = 1;
            "widget.use-xdg-desktop-portal.open-uri" = 1;
            "browser.aboutConfig.showWarning" = false;
            "browser.compactmode.show" = true;
            "browser.cache.disk.enable" = false; # Be kind to hard drive

            "mousewheel.default.delta_multiplier_x" = 20;
            "mousewheel.default.delta_multiplier_y" = 20;
            "mousewheel.default.delta_multiplier_z" = 20;

            # Firefox 75+ remembers the last workspace it was opened on as part of its session management.
            # This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
            # then have Firefox open on some other workspace.
            #"widget.disable-workspace-management" = true;
          };
          search = {
            force = true;
            default = "DuckDuckGo";
            order = [ "DuckDuckGo" "Bing" ];
          };
          #bookmarks = {
          #  name = "HackRF Software Support";
          #  url = "https://hackrf.readthedocs.io/en/latest/software_support.html";
          #};
        };
      };
    };
  };
}
