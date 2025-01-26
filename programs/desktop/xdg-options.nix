{ lib, config, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = ["org.gnome.Nautilus.desktop" "org.kde.dolphin.desktop" "dolphin.desktop"];
        "video/x-matroska" = ["mpv" "vlc-2.desktop"];
        # "image/png" = "org.kde.gwenview.desktop";
        # "image/jpg" = "org.kde.gwenview.desktop";
        # "application/pdf" = "org.kde.okular.desktop";
      };
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" "org.kde.dolphin.desktop" "dolphin.desktop"];
      };
    };
    xdg.userDirs = {
      desktop = "${config.home.homeDirectory}/.local/share/Desktop";
    };
  };
}
