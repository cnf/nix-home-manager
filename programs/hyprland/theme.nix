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
      # gsettings set org.gnome.nautilus.window-state initial-size
      enable = true;
      font = {
        # name = "JetBrainsMono Nerd Font";
        # name = "Helvetica Neu LT Std";
        name = config.my.looks.font.name;
        size = config.my.looks.font.size;
      };
      theme = {
        name = config.my.looks.theme.gtk.name;
        #name = "Tokyonight-Orange-Dark";
        package = config.my.looks.theme.gtk.package;
        #package = pkgs.tokyo-night-gtk.override {
        #  themeVariants = ["orange" "default"];
        #  #iconVariants = ["Dark"];
        #};
      };
      iconTheme = {
        name = config.my.looks.icons.name;
        package = config.my.looks.icons.package;
        #package = pkgs.kdePackages.breeze-icons;
        #name = "breeze-dark";
      };
      gtk3.extraConfig = {gtk-application-prefer-dark-theme = 1;};
      #gtk4.extraConfig = {gtk-application-prefer-dark-theme = 1;};
    };
    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:close";
      };
      "org/gnome/nautilus/window-state" = {
        initial-size = lib.hm.gvariant.mkTuple [1000 700];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
    qt.enable = true;
    qt.platformTheme.name = "gtk3";
    qt.style.name = "gtk2";
  };
}
