{ pkgs, unstable, lib, config, inputs, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = ["org.kde.dolphin.desktop" "dolphin.desktop"];
        "video/x-matroska" = ["mpv" "vlc-2.desktop"];
        "image/png" = "org.kde.gwenview.desktop";
        "image/jpg" = "org.kde.gwenview.desktop";
        "application/pdf" = "org.kde.okular.desktop";
      };
      defaultApplications = {
        "inode/directory" = ["org.kde.dolphin.desktop" "dolphin.desktop"];
      };
    };
  };
}
