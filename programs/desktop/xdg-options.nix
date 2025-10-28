{ lib, config, ... }:
{
  config = lib.mkIf config.my.desktop.enable {
    xdg.mimeApps = {
      enable = false;
      associations.added = {
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
      #  "video/x-matroska" = ["mpv" "vlc-2.desktop"];
      #  # "image/png" = "org.kde.gwenview.desktop";
      #  # "image/jpg" = "org.kde.gwenview.desktop";
      #  # "application/pdf" = "org.kde.okular.desktop";
      };
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      };
    };
    xdg.portal.enable = true;
    xdg.userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/.local/share/Desktop";
      templates = "${config.home.homeDirectory}/.local/share/Templates";
      music = "${config.xdg.userDirs.documents}/Music";
      pictures = "${config.xdg.userDirs.documents}/Pictures";
      videos = "${config.xdg.userDirs.pictures}/Videos";
    };
    xdg.systemDirs.data = [
      "/usr/share"
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };
}
