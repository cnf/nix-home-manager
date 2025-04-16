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
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk3.extraCss = config.my.looks.theme.gtk.extraCss;
      gtk4.extraCss = config.my.looks.theme.gtk.extraCss;
      # gtk4.extraCss = ''
      #   /* Evolution Mail */
      #   /*MessageList {
      #   color: red;
      #   }*/
      #   MessageList,* {
      #           -MessageList-new-mail-fg-color: SteelBlue;
      #   }

      #   /* geary */
      #   row.conversation-list {
      #     color: silver;
      #   }

      #   row.conversation-list .participants {
      #     font-weight: bold;
      #     font-size: 120%;

      #   }
      #   row.conversation-list .preview {
      #     color: gray;
      #     font-size: 80%
      #   }
      #   row.conversation-list .subject {
      #     font-weight: normal;
      #   }

      #   row.conversation-list.unread {
      #     border-left: 5px #0A84FF solid;
      #     color: white;
      #   }

      #   row.conversation-list.unread {
      #     color: white;
      #   }

      # '';
    };
    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:";
      };
      "org/gnome/nautilus/window-state" = {
        initial-size = lib.hm.gvariant.mkTuple [
          1000
          700
        ];
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
