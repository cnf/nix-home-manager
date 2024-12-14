{ pkgs, lib, config, inputs, unstable, ... }:
{
  config = lib.mkIf config.my.hyprland.enable {
    my.desktop.enable = true;
    home.sessionVariables = {
        #"QT_QPA_PLATFORM,wayland"
        #"XDG_CURRENT_DESKTOP,Hyprland"
        #"XDG_SESSION_TYPE,wayland"
        #"XDG_SESSION_DESKTOP,Hyprland"
      XCURSOR_SIZE = 24;
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND = 1;
      NIXOS_OZONE_WL = 1;
      HYPRSHOT_DIR = "${config.xdg.userDirs.pictures}/Screenshots/";
    };
    home.packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      wlr-randr
      hyprpolkitagent
      hyprsunset
      hyprpicker
      hyprutils
      hyprlang
      aquamarine
      hyprshade
      
      emojipick
      pavucontrol
      playerctl
      blueman
     # polkit-kde-agent < TODO
      #kitty
      wev
      networkmanagerapplet
      networkmanager_dmenu

      # screenshots
      grim
      slurp
      hyprshot
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      inputs.hyprswitch.packages.${pkgs.system}.default
      inputs.hyprsysteminfo.packages.${pkgs.system}.default

      # idle
    ];

    services.gnome-keyring.enable = true;
    services.network-manager-applet.enable = false;
    services.blueman-applet.enable = true;
    services.swayosd.enable = true;
    services.playerctld.enable = true;

    wayland.windowManager.hyprland = {
      enable  = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      plugins  = [
        inputs.hyprgrass.packages.${pkgs.system}.hyprgrass
        inputs.hyprspace.packages.${pkgs.system}.Hyprspace
        # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexo
      ];
    };
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$shiftmod" = "SUPER SHIFT";
      # $wob_socket        = $XDG_RUNTIME_DIR/wob.sock # Used like $wob_socket <number>
      "$sink_volume" = "pactl get-sink-volume @DEFAULT_SINK@ | grep '^Volume:' | cut -d / -f 2 | tr -d ' ' | sed 's/%//'";
      "$sink_volume_mute" = "pactl get-sink-mute @DEFAULT_SINK@ | sed -En \"/no/ s/.*/$($sink_volume)/p; /yes/ s/.*/0/p\"";

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "desc:BOE NE135A1M-NY1,preferred,auto,2,vrr,1"
        "desc:LG Electronics LG ULTRAWIDE 0x0000A6C2,preferred,auto,1"
        "desc:XYK Display demoset-1,preferred,auto,1"
        ",preferred,auto,1"
        "FALLBACK,1920x1080@60,auto,1"
      ];

      exec-once = [
        "waybar"
        "hypridle"
        "dunst"
        #"hyprpaper"
        "nm-applet --indicator "
        "bluetooth-applet"
        "1password --silent"
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
        "systemctl --user start hyprpolkitagent"
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] kitty"
        "[workspace 4 silent] discord"

      ];

      #env = [
      #  "XCURSOR_SIZE,24"
      #  "MOZ_ENABLE_WAYLAND,1"
      #  "NIXOS_OZONE_WL,1"
      #  "QT_QPA_PLATFORM,wayland"
      #  "XDG_CURRENT_DESKTOP,Hyprland"
      #  "XDG_SESSION_TYPE,wayland"
      #  "XDG_SESSION_DESKTOP,Hyprland"
      #  "_HYPRSHOT_DIR,$XDG_PICTURES_DIR/Screenshots/"
      #];

      misc = {
        focus_on_activate = true; # Whether Hyprland should focus an app that requests to be focused (an activate request)
        disable_hyprland_logo=true;
        vrr = 1;
      };

      bindd = [
        ## Screenshots
        ", Print, Screenshot entire screen, exec, hyprshot -m output"
        "Control_L, Print, Screenshot window, exec, hyprshot -m window"
        "Control SHIFT, Print, Screenshot selected area, exec, hyprshot -m region"
        "$mod, Print, Show screen capture menu, exec, rofi-screenshot"
        "$shiftmod, Print, Stop Recording, exec, rofi-screenshot -s"

        ## Various
        "$mod, K, Quick Calculator, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command 'echo -n {result}| wl-copy'"
        "$shiftmod, J, Color Picker, exec, hyprpicker -a -n| xargs -I % notify-send hyprpicker 'Copied % to clipboard'"
      ];
      bind = [
        # TODO: hyprswitch
        #"$mod, Tab, exec, hyprswitch gui --mod-key super  --key tab --max-switch-offset 9 --close mod-key" #--hide-active-window-border"
        "$mod, T, fullscreen, 0"
        # "$mod, Tab, cyclenext,"
        "$mod, G, togglegroup"
        "alt, GRAVE, changegroupactive"
        "alt, 1, changegroupactive, 1"
        "alt, 2, changegroupactive, 2"
        "alt, 3, changegroupactive, 3"
        "alt, 4, changegroupactive, 4"
        "alt, 5, changegroupactive, 5"
        "alt, 6, changegroupactive, 6"
        # Main keybinds
        "$mod, F4, killactive, # close the active window"
        "$mod, L, exec, hyprlock #lock the active window"
        "$mod, M, exec, nwg-bar # show the logout window"
        "$shiftmod, M, exit, # Exit Hyprland all together no (force quit Hyprland)"
        # stuff
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, F, togglefloating, # Allow a window to float"
        "$shiftmod, F, fullscreen, 1, #Toggle Full Screen"
        "$mod, SPACE, exec, rofi -show drun # Show the graphical app launcher"
        # "$mod, ESCAPE, hyprexpo:expo, toggle"
        #"$mod, SPACE, exec, anyrun"
        "ALT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy # open clipboard manager"
        "$mod, A, exec, hyprctl keyword general:layout master"
        "$shiftmod, A, exec, hyprctl keyword general:layout dwindle"
        # Master,
        "$mod, S, layoutmsg, orientationcycle right center"
        # Dwindle
        "$mod, P, pseudo, # Dwindle"
        "$mod, J, togglesplit, # Dwindle"

        # halp!
        "$shiftmod, code:61, exec, hypr-binds"
        "$mod, code:61, exec, hypr-binds"

        ### NAVIGATION ###
        "$mod, u, focusurgentorlast"
        # Switch workspaces with mainMod + [0-9]
        "$mod, grave, togglespecialworkspace, visor"
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
        "$shiftmod, grave, movetoworkspace, special, visor"
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
      ];
      binddl = [
        # ", XF86AudioMute, Mute audio, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMute, Mute Audio, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioRaiseVolume, Volume up, exec, swayosd-client --output-volume raise --max-volume=100"
        ", XF86AudioLowerVolume, Volume down, exec,swayosd-client --output-volume lower"
        ", XF86AudioPlay, Play/Pause, exec, playerctl play-pause"
        ", XF86AudioPrev, Previous Song, exec, playerctl previous"
        ", XF86AudioNext, Next Song, exec, playerctl next"
        ", XF86MonBrightnessUp, Raise brightness, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, Lower brightness, exec, swayosd-client --brightness lower"
        ", XF86AudioMedia, Not Bound Yet, exec, notify-send 'not bound yet'"
        # ", Super_L, Not Bound yet, exec, notify-send 'Not bound yet'" # fn > F9

        ### LAPTOP LID
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
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
        kb_options = "ctrl:nocaps";
      };
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 4;
        "col.active_border" = "rgba(ff6700ee)";
        "col.inactive_border" = "rgba(0098ffaa)";
        layout = "master";
        resize_on_border = true;
        snap = {
          enabled = true;
        };
      };
      dwindle = {
        pseudotile = "yes"; #master switch for pseudotiling. Enabling is bound to mod+P
        preserve_split = "yes";
      };
      master = {
        always_center_master = true;
        #new_is_master = false;
        orientation = "right";
        mfact = 0.7; # 0.55 default
  #
      };
      gestures = {
        workspace_swipe = true;
        #workspace_swipe_use_r = true;
      };
      decoration = {
        rounding=6;
        shadow = {
          enabled = true;
          range = 10;
          render_power = 4;
          #color = "rgba(ff6700ee)"; #"rgba(1a1a1aee)";
          #color_inactive = "rgba(0098ff33)";
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
        auto_group = false;
        drag_into_group = 1;
        "col.border_active" = "rgba(ff6700ee)";
        "col.border_inactive" = "rgba(0098ff33)";
        groupbar = {
          gradients = true;
          "col.active" = "rgba(ff6700ee)";
          "col.inactive" = "rgba(0098ff33)";
        };
      };
      workspace = [
#        "1, defaultName:browser, persistent:1"
#        "2, defaultName:shell, persistent:1"
#        "3, defaultName:code, persistent:1"
#        "4, defaultName:chat, persistent:1"
        "special:visor, on-created-empty:kitty"
      ];
      animations = {
        enabled=true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        # https://easings.net/
        # https://www.cssportal.com/css-cubic-bezier-generator/
        bezier = [
        # "myBezier, 0.10, 0.9, 0.1, 1.05"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "easeOutQuart, 0.25, 1, 0.5, 1"
        ];

        animation = [
          "windows, 1, 5, easeOutQuart, slide"
          "windowsOut, 1, 5, easeOutQuart, slide"
          "border, 1, 10, default"
          "fade, 1, 6, default"
          "workspaces, 1, 5, easeOutQuart"
          "specialWorkspace, 1, 3, easeOutQuart, slidefadevert -50%"
        ];
      };
      #windowrule = [
      #  "float, ^(kitty)$"
      #];
      windowrulev2 = [ 
        # special workspace
        "float,onworkspace:s[true]"
        "size 90% 80%, onworkspace:s[true]"
        "bordercolor rgba(FF6700EE) rgba(0098FF66) 60deg, onworkspace:s[true]"

        # Pin App to workspaces#
        "workspace 4 silent, class:^(discord)$"


        "float,class:(nm-tray)"
        "float,class:^(pavucontrol)$"
        "float,class:^(.blueman.*)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(org.pulseaudio.pavucontrol)$"
        "float,class:^(org.gnome.Nautilus)$"
        "float,class:^(org.kde.dolphin)$"
        # Code
        "opacity 0.95 override 0.8 override,class:^(Code)$"
        # Video
        "float,class:^(vlc)$"
        "opacity 1 override 0.8 override,class:^(vlc)$"
        "float,initialTitle:^(Picture-in-Picture)$"
        ### 1Password
        #"float, class:^(1Password)$"
        "stayfocused, class:^(1Password)$, title:(Quick Access)"
        "center, class:^(1Password)$, title:(Quick Access)"
        "tag +1password, class:^(1Password)$, title:^((?!Quick Access).)*$"
        #"tag -1password, title:^(Quick Access.*)$"
        #"tag -1password, title:^((?!Quick Access).)*$"
        "float, tag:1password"
        "size 70% 70%, tag:1password"
        "center, tag:1password"
        #"stayfocused, tag:1password"
        "animation popin, tag:1password"
        # Rofi
        "move cursor -3% -105%,class:^(rofi)$"
        "noanim,class:^(rofi)$"
        "opacity 0.8 override 0.6 override,class:^(rofi)$"
        ## Steam
        "tag +steam, initialClass:^(steam)$"
        "tag +steam, initialTitle:^(Steam)$"
        "noborder, floating:1, tag:steam"
        "noshadow, floating:1, tag:steam"

        ## OneDrive GUI ##
        "tag +onedrive, title:^(OneDriveGUI .*)$"
        "float, tag:onedrive"
        "center, tag:onedrive"
        "size: 80%, tag:onedrive"

        ### Security ###
        "stayfocused,  class:^(pinentry-) # fix pinentry losing focus"
        ### Open/Save Dialogs ###
        "tag +opensave, class:org.freedesktop.impl.portal.desktop.kde, title:(Enter name of ([a-zA-Z]*) to (open|save to))"
        "tag +opensave, title:^((Open|Save) ([a-zA-Z]*))$"
        "float,tag:opensave"
        "size 70% 70%,tag:opensave"
        "center, tag:opensave"
        "stayfocused,tag:opensave"
      ];
    };
    wayland.windowManager.hyprland.extraConfig = ''
        # will switch to a submap called resize
        bind=ALT,R,submap,resize

        # will start a submap called "resize"
        submap=resize

        # sets repeatable binds for resizing the active window
        binde=, right, resizeactive,10 0
        binde=, left, resizeactive,-10 0
        binde=, up, resizeactive,0 -10
        binde=, down, resizeactive,0 10
        binde=, Prior, layoutmsg,mfact +0.01
        binde=, Next, layoutmsg, mfact -0.01

        # use reset to go back to the global submap
        bind=,escape,submap,reset 

        # will reset the submap, which will return to the global submap
        submap=reset

        # keybinds further down will be global again...
        plugin {
          overview {
            autoDrag = true
            affectStrut = false
          }
          # hyprexpo {
          #   columns = 2
          #   gap_size = 6
          #   bg_col = rgba(0098ff77)
          #   workspace_method = first 1 # [center/first] [workspace] e.g. first 1 or center m+1

          #   enable_gesture = true # laptop touchpad
          #   gesture_fingers = 4  # 3 or 4
          #   gesture_distance = 300 # how far is the "max"
          #   gesture_positive = true # positive = swipe down. Negative = swipe up.
          # }
        }
      '';

  gtk = {
   enable = true;
   #cursorTheme = {
   #  name = "Catppuccin-Macchiato-Dark-Cursors";
   #  package = pkgs.catppuccin-cursors.macchiatoDark;
   #};

   iconTheme = {
     package = pkgs.catppuccin-papirus-folders.override {
       flavor = "macchiato";
       accent = "mauve";
     };
     name = "Papirus-Dark";
   };

   theme = {
     package = pkgs.catppuccin-gtk.override {
       accents = ["mauve"];
       size = "standard";
       variant = "macchiato";
     };
     name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
   };
  };

  };
}
