{ pkgs, lib, config, inputs, unstable, ... }:

{
  #options = {
  #  my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
  #};
  config = lib.mkIf config.my.hyprland.enable {
    my.desktop.enable = true;
    # make stuff work on wayland
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND=1;
    };
    home.packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      hyprpolkitagent
      hyprsunset
      hyprpicker
      hyprutils
      hyprlang
      aquamarine
      hyprshade
      
      #qt5-wayland
      #qt6-wayland
      pavucontrol
      blueman
     # polkit-kde-agent < TODO
      #kitty
      wev
      networkmanagerapplet

      # screenshots
      grim
      slurp
      hyprshot
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

      # idle
    ];

    services.network-manager-applet.enable = false;
    services.blueman-applet.enable = true;

    wayland.windowManager.hyprland = {
      enable  = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      plugins  = [
        inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
        # inputs.hyprsysteminfo.packages.${pkgs.system}.hyprsysteminfo
        #inputs.hyprspace.packages.${pkgs.system}.Hyprspace
        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      ];
    };
    wayland.windowManager.hyprland.settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "desc:BOE NE135A1M-NY1,preferred,auto,2"
        ",preferred,auto,1"
        "desc:XYK Display demoset-1,preferred,auto,1"
      ];
      exec-once = [
        "waybar"
        "hypridle"
        "dunst"
        #"hyprpaper"
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
        "1password --silent"
        ""
      ];
      "$mod" = "SUPER";
      "$shiftmod" = "SUPER SHIFT";
      # $wob_socket        = $XDG_RUNTIME_DIR/wob.sock # Used like $wob_socket <number>
      "$sink_volume" = "pactl get-sink-volume @DEFAULT_SINK@ | grep '^Volume:' | cut -d / -f 2 | tr -d ' ' | sed 's/%//'";
      "$sink_volume_mute" = "pactl get-sink-mute @DEFAULT_SINK@ | sed -En \"/no/ s/.*/$($sink_volume)/p; /yes/ s/.*/0/p\"";

      env = [
        "XCURSOR_SIZE,24"
        "MOZ_ENABLE_WAYLAND,1"
        "QT_QPA_PLATFORM,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      misc.disable_hyprland_logo=true;

      bindd = [
        # Screenshots
        #"$mod, PRINT, exec, hyprshot -m window"
        #", PRINT, exec, hyprshot -m output"
        #"$shiftmod, PRINT, exec, hyprshot -m region"
        ", Print, Screenshot entire screen, exec, hyprshot -m output" #grimblast --notify copysave screen"
        "$mod, Print, Screenshot active window,exec, hyprshot -m active" #grimblast copysave active"
        "$shiftmod, Print, Screenshot selected area, exec, hyprshot -m area"
      ];
      bind = [
        "$mod, G, togglegroup"
        "$mod, GRAVE, changegroupactive"
        # Main keybinds
        "$mod, F4, killactive, # close the active window"
        "$mod, L, exec, hyprlock #lock the active window"
        #"$mod, M, exec, wlogout --protocol layer-shell # show the logout window"
        "$mod, M, exec, nwg-bar # show the logout window"
        #"$mod, M, exit,"
        "$shiftmod, M, exit, # Exit Hyprland all together no (force quit Hyprland)"
        # stuff
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, V, togglefloating, # Allow a window to float"
        "$mod, SPACE, exec, rofi -show drun # Show the graphical app launcher"
        "$mod, ESCAPE, hyprexpo:expo, toggle"
        #"$mod, SPACE, exec, anyrun"
        "ALT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy # open clipboard manager"
        "$mod, A, exec, hyprctl keyword general:layout master"
        "$shiftmod, A, exec, hyprctl keyword general:layout dwindle"
        # Master,
        "$mod, S, layoutmsg, orientationcycle right center"

        # Dwindle
        "$mod, P, pseudo, # Dwindle"
        "$mod, J, togglesplit, # Dwindle"
        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$shiftmod, 1, movetoworkspace, 1"
        "$shiftmod, 2, movetoworkspace, 2"
        "$shiftmod, 3, movetoworkspace, 3"
        "$shiftmod, 4, movetoworkspace, 4"
        "$shiftmod, 5, movetoworkspace, 5"
        "$shiftmod, 6, movetoworkspace, 6"
        "$shiftmod, 7, movetoworkspace, 7"
        "$shiftmod, 8, movetoworkspace, 8"
        "$shiftmod, 9, movetoworkspace, 9"
        "$shiftmod, 0, movetoworkspace, 0"
        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        # halp!
        "$shiftmod, code:61, exec, $HOME/.config/hypr/keys.sh"
        "$mod, code:61, exec, $HOME/.config/hypr/keys.sh"

      ];
      binddl = [
        ", XF86AudioMute, Mute audio, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, Volume up, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, Volume down, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, Raise brightness, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, Lower brightness, exec, brightnessctl set 5%-"
        # trigger when the switch is turning off
        ", switch:off:Lid Switch, Laptop open,exec,hyprctl keyword monitor \"eDP-1, preferred,auto,2\""
        # trigger when the switch is turning on
        ", switch:on:Lid Switch, Laptop closes,exec,hyprctl keyword monitor \"eDP-1, disable\""

      ];
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
      input = {
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        scroll_factor = 1.5;
        touchpad = {
          natural_scroll = "yes";
        };
        kb_options = "ctrl:nocaps";
      };
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 4;
        # "col.active_border" = "rgba(ff6700ee) rgba(ff8939ee) 50deg";
        "col.active_border" = "rgba(ff6700ee)";
        "col.inactive_border" = "rgba(0098ffaa)";
        layout = "master";
      };
      dwindle = {
        pseudotile = "yes #master switch for pseudoriling. Enabling is bound to mod+P";
        preserve_split = "yes";
      };
      master = {
        always_center_master = true;
        #new_is_master = false;
        orientation = "right";
  #
      };
      gestures = {
        workspace_swipe = true;
      };
      decoration = {
        rounding=6;
        shadow = {
          enabled = true;
          range = 10;
          render_power = 4;
          color = "rgba(ff6700ee)"; #"rgba(1a1a1aee)";
          color_inactive = "rgba(0098ff33)";
        };
        active_opacity=0.8;
        inactive_opacity=0.7;
        blur = {
          enabled=true;
          size=7;
          passes=4;
          new_optimizations=true;
          noise=0.04;
          vibrancy=0.2; #0.1696
        };
      };
      group = {
        drag_into_group = 2;
        "col.border_active" = "rgba(ff6700ee)";
        "col.border_inactive" = "rgba(0098ff33)";
        groupbar = {
          "col.active" = "rgba(ff6700ee)";
          "col.inactive" = "rgba(0098ff33)";
        };
      };
      animations = {
        enabled=true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier="myBezier, 0.10, 0.9, 0.1, 1.05";

        animation= [
          "windows, 1, 7, myBezier, slide"
          "windowsOut, 1, 7, myBezier, slide"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      #windowrule = [
      #  "float, ^(kitty)$"
      #];
      windowrulev2 = [ 
        "float,class:^(pavucontrol)$"
        "float,class:^(.blueman.*)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(org.pulseaudio.pavucontrol)$"
        "float,class:^(org.gnome.Nautilus)$"
        "float,class:^(org.kde.dolphin)$"
        "opacity 1.0 0.9,class:^(Code)$"
        "float,initialTitle:^(Picture-in-Picture)$"
        "float,class:(1Password)"
        "size 70% 70%,class:(1Password)"
        "center,class:(1Password)"
        "stayfocused,class:(1Password)"
        "move cursor -3% -105%,class:^(rofi)$"
        "noanim,class:^(rofi)$"
        "opacity 0.8 0.6,class:^(rofi)$"
      ];
    };
    wayland.windowManager.hyprland.extraConfig = ''
        # will switch to a submap called resize
        bind=ALT,R,submap,resize

        # will start a submap called "resize"
        submap=resize

        # sets repeatable binds for resizing the active window
        binde=,right,resizeactive,10 0
        binde=,left,resizeactive,-10 0
        binde=,up,resizeactive,0 -10
        binde=,down,resizeactive,0 10

        # use reset to go back to the global submap
        bind=,escape,submap,reset 

        # will reset the submap, which will return to the global submap
        submap=reset

        # keybinds further down will be global again...
        plugin {
          hyprexpo {
            columns = 2
            gap_size = 6
            bg_col = rgba(0098ff77)
            workspace_method = first 1 # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true # laptop touchpad
            gesture_fingers = 4  # 3 or 4
            gesture_distance = 300 # how far is the "max"
            gesture_positive = true # positive = swipe down. Negative = swipe up.
          }
          #hyprbars {
          #  # example config
          #  bar_height = 20
          #  bar_part_of_window = true
          #  bar_precedence_over_border = true
          #  bar_button_padding = 10

          #  # example buttons (R -> L)
          #  # hyprbars-button = color, size, on-click
          #  hyprbars-button = rgb(FF605C), 15, , hyprctl dispatch killactive
          #  hyprbars-button = rgb(ffBD44), 15, , hyprctl dispatch togglefloating
          #  hyprbars-button = rgb(00CA4E), 15, , hyprctl dispatch fullscreen 1
          #}
        }
      '';

  #gtk = {
  #  enable = true;
  #  cursorTheme = {
  #    name = "Catppuccin-Macchiato-Dark-Cursors";
  #    package = pkgs.catppuccin-cursors.macchiatoDark;
  #  };

  #  iconTheme = {
  #    package = pkgs.catppuccin-papirus-folders.override {
  #      flavor = "macchiato";
  #      accent = "mauve";
  #    };
  #    name = "Papirus-Dark";
  #  };

  #  theme = {
  #    package = pkgs.catppuccin-gtk.override {
  #      accents = ["mauve"];
  #      size = "standard";
  #      variant = "macchiato";
  #    };
  #    name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
  #  };
  #};

  };
}
