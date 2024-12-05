{pkgs, ...}:
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type="solid";
      picture-options = "zoom";
      picture-uri="file://${pkgs.gnome-backgrounds}/share/backgrounds/gnome/truchet-l.jpg";
      picture-uri-dark="file://${pkgs.gnome-backgrounds}/share/backgrounds/gnome/truchet-d.jpg";
      primary-color="#ac5e0b";
      secondary-color="#000000";
    };
  };
}
