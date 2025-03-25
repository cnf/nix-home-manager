{ lib, config, ... }:
{
  config = lib.mkIf config.my.hyprland.enable {
    home.pointerCursor = {
      gtk.enable = true;
      # hyprcursor.enable = true;
      name = config.my.looks.cursor.name;
      package = config.my.looks.cursor.package;
      size = config.my.looks.cursor.size;
    };
    gtk = {
      enable = true;
      font = {
        name = config.my.looks.font.name;
        size = config.my.looks.font.size;
      };
      theme = {
        name = config.my.looks.theme.gtk.name;
        package = config.my.looks.theme.gtk.package;
      };
      iconTheme = {
        name = config.my.looks.icons.name;
        package = config.my.looks.icons.package;
      };
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};
    };
    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:";
      };
      "org/gnome/nautilus/window-state" = {
        initial-size = lib.hm.gvariant.mkTuple [1000 700];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
    qt.enable = true;
    qt.platformTheme.name = "gtk2";
    qt.style.name = "gtk2";
  };
}
