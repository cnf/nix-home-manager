# cSpell:words pkgs dmenu stdenv nordzy
# cSpell:ignoreRegExp hypr\w* 
{ pkgs, lib, config, inputs, unstable, ... }:
let
  hyprland-pkg = pkgs.hyprland;
  #hyprland-pkg = unstable.hyprland.override {libgbm = unstable.mesa;};
  #hyprland-pkg = inputs.hyprland.packages.${pkgs.system}.hyprland; #.override {libgbm = unstable.mesa;};

  hypr-packages = with pkgs;[
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    hyprpwcenter
    hyprlauncher
    inputs.dmenu-usbguard.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.hyprsysteminfo.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  hypr-plugins = with pkgs;[
    hyprlandPlugins.hyprspace
    hyprlandPlugins.hyprgrass
  ];
  #hypr-packages = [ 
  #  inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
  #  inputs.hyprpolkitagent.packages.${pkgs.stdenv.hostPlatform.system}.default
  #  #inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  #  inputs.dmenu-usbguard.defaultPackage.${pkgs.stdenv.hostPlatform.system}
  #  inputs.hyprswitch.packages.${pkgs.stdenv.hostPlatform.system}.default
  #  inputs.hyprsysteminfo.packages.${pkgs.stdenv.hostPlatform.system}.default
  #  inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
  #];
  #hypr-plugins = [
  #  inputs.hyprspace.packages.${pkgs.stdenv.hostPlatform.system}.default
  #  #pkgs.hyprlandPlugins.hyprgrass
  #  #pkgs.hyprlandPlugins.hyprspace
  #];
in
{
  config = lib.mkIf config.my.hyprland.enable {
    my.desktop.enable = true;
    my.kitty.enable = true;
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      XCURSOR_SIZE = config.my.looks.cursor.size;
      QT_QPA_PLATFORM = "wayland";
      #QT_QPA_PLATFORMTHEME = "gtk2";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = 1;
      NIXOS_XDG_OPEN_USE_PORTAL = 1;
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      #HYPRCURSOR_THEME = config.my.looks.cursor.name;
      #HYPRCURSOR_SIZE = config.my.looks.cursor.size;
      #GTK_THEME = "${config.my.looks.theme.gtk.name}";
      HYPRSHOT_DIR = "${config.xdg.userDirs.pictures}/Screenshots/";
    };
    home.packages = with pkgs; [
      hyprpicker #/gbm
      qt5.qtwayland

      wlr-randr
      xdg-desktop-portal-gtk
      # screenshots
      grim
      slurp
      hyprshot
      grimblast
      swappy

      # hyprland-monitor-attached

      emojipick
      pavucontrol
      playerctl
      wev
      networkmanagerapplet
      networkmanager_dmenu


      nordzy-cursor-theme
      #rose-pine-cursor

      # for gnome-keyring
      gcr

    ] ++ hypr-packages;

    services.gnome-keyring.enable = true;
    #services.gnome-keyring.components = ["secrets"];
    services.network-manager-applet.enable = true;
    services.swayosd.enable = true;
    services.playerctld.enable = true;

    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    xdg.portal.configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    #xdg.dataFile."dbus-1/services/org.freedesktop.impl.portal.desktop.hyprland.service".source =
    #    "${pkgs.xdg-desktop-portal-hyprland}/share/dbus-1/services/org.freedesktop.impl.portal.desktop.hyprland.service";

    wayland.windowManager.hyprland = {
      enable  = true;
      package = hyprland-pkg;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
      };
      plugins  = hypr-plugins;
      sourceFirst = true;
    };
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$shiftmod" = "SUPER SHIFT";

      source = [
        "~/.config/hypr/local.conf"
      ];

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "desc:BOE NE135A1M-NY1,preferred,0x0,2,vrr,1"
        "desc:LG Electronics LG ULTRAWIDE 0x0000A6C2,preferred,-1000x-1440,1"
        "desc:BNQ BenQ LCD 56G04894019,preferred,auto-up,1"
        "desc:XYK Display demoset-1,preferred,auto,1"
        ",preferred,auto,1"
        "FALLBACK,1920x1080@60,auto,1"
      ];

      workspace = [
        "1, monitor:desc:BOE NE135A1M-NY1"
        "2, monitor:desc:BOE NE135A1M-NY1"
        "3, monitor:desc:BOE NE135A1M-NY1, default:true"
        "4, monitor:desc:BOE NE135A1M-NY1"
        "5, monitor:desc:BOE NE135A1M-NY1"
        "6, monitor:desc:BOE NE135A1M-NY1"
        "7, monitor:desc:BOE NE135A1M-NY1"
        "8, monitor:desc:BOE NE135A1M-NY1"
        "9, monitor:desc:BOE NE135A1M-NY1"
        "10, monitor:desc:BOE NE135A1M-NY1"
        #"15, monitor:ID:1,default:true"
        #"15, monitor:1,default:true"
        #"13, monitor:DP-2, default:true"
        "special:visor, on-created-empty:kitty btop -p 1"
        "special:music, on-created-empty:spotify"
        "special:popterm, on-created-empty:kitty"
      ];

      exec-once = [
        #"waybar"
        #"hypridle"
        #"dunst" #service?
        #"hyprpaper" #service?
        #"nm-applet --indicator" #service?
        #"usbguard-notifier" #service?
        "wl-paste --type text --watch cliphist -max-items 50 store #Stores only text data"
        "wl-paste --type image --watch cliphist -max-items 50 store #Stores only image data"
        "1password --silent"
        "systemctl --user restart usbguard-notifier.service"
        "systemctl --user restart yubikey-agent.service"
        "systemctl --user restart hyprpolkitagent.service"
        "systemctl --user restart waybar.service"
        "systemctl --user restart autoname-workspaces.service"
        #"systemctl restart --user app-blueman@autostart.service"
        #"ignis init"
        #"hyprland-autoname-workspaces"
        #"udiskie -t"
        #"tailscale-systray"
        #"tail-tray"
        "[workspace 1 silent] kitty"
        "[workspace 3 silent] firefox"
        "[workspace 4 silent] discord"

      ];

      env = [
        "HYPRCURSOR_THEME,${config.my.looks.cursor.name}"
        "HYPRCURSOR_SIZE,${toString config.my.looks.cursor.size}"
        "XCURSOR_THEME,${config.my.looks.cursor.name}"
        "XCURSOR_SIZE,${toString config.my.looks.cursor.size}"
        "GTK_THEME,${config.my.looks.theme.gtk.name}"
        "NIXOS_OZONE_WL,1"
        "NIXOS_XDG_OPEN_USE_PORTAL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "HYPRSHOT_DIR,${config.xdg.userDirs.pictures}/Screenshots/"
        #"XDG_MENU_PREFIX,plasma-"
      ];

      misc = {
        font_family = config.my.looks.font.name;
        focus_on_activate = true; # Whether Hyprland should focus an app that requests to be focused (an activate request)
        disable_hyprland_logo=true;
        initial_workspace_tracking = 2;
        enable_swallow = true;
        swallow_regex = [
          "kitty"
        ];
        swallow_exception_regex = "^(glxgears|vkcube|xev|wev|zenity|yad)$";
        vrr = 1;
        vfr = true;
      };

      bindd = [
        # Main keybinds
        "$shiftmod, M, Exit Hyperland now, exit, # Exit Hyprland all together now (force quit Hyprland)"
        "$mod, F4, Close active window, killactive"
        "$mod, W, Close active window, killactive"
        "$mod, L, Locks Desktop, exec, hyprlock"
        "$mod, F, Toggle fullscreen, fullscreen, 0 # Toggle active window to fullscreen"
        "$mod, M, Toggle maximize, fullscreen, 1 # Maximize Window"
        "$mod, T, Toggle floating/tiling, togglefloating # Allow a window to float"

        # Master
        "$mod, A, Master Layout, exec, hyprctl keyword general:layout master"
        "$mod, S, Master Orientation Cycle, layoutmsg, orientationcycle right center"
        # Dwindle
        "$shiftmod, A, Dwindle Layout, exec, hyprctl keyword general:layout dwindle"
        "$mod, P, Dwindle Pseudo, pseudo, # Dwindle"
        "$mod, J, Dwindle Toggle Split, togglesplit, # Dwindle"

        ## Screenshots
        ", Print, Screenshot entire screen, exec, hyprshot -z -m active -m output"
        "Control_L, Print, Screenshot window, exec, hyprshot -z -m window"
        "Control SHIFT, Print, Screenshot selected area, exec, hyprshot -z -m region"
        "$mod, Print, Edit last screenshot, exec, wl-paste | swappy -f - | wl-copy"
        # hyprshot -m region --clipboard-only --freeze && wl-paste | swappy -f

        ## Various Launchers
        "$mod, SPACE, App Launcher Menu, exec, rofi -show drun # Show the graphical app launcher"
        "$mod, Return, Kitty Terminal, exec, kitty"
        "$mod, BackSpace, Nautilus File Browser, exec, nautilus"
        #"$mod, K, Kitty Terminal, exec, kitty"
        "$mod, equal, Calculator, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command 'echo -n {result}| wl-copy'"
        "$shiftmod, J, Color Picker, exec, hyprpicker -a -n| xargs -I % notify-send hyprpicker 'Copied % to clipboard'"
        "Alt, V, Clip Board, exec, rofi -modi clipboard:cliphist-rofi-img -show clipboard -show-icons"
        "Control_L Alt_L, V, Erase from Clipboard, exec, cliphist list | rofi -dmenu -p Delete| cliphist delete"

        # Workspaces
        "$mod, left, Go to previous workspace,workspace, e-1" 
        "$mod, right, Go to next workspace,workspace, e+1" 
        "$shiftmod, left, Go to previous workspace,workspace, m-1" 
        "$shiftmod, right, Go to next workspace,workspace, m+1" 
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
            let
              ws = if i == 0 then 10 else i;
            in [
              "$mod, ${toString i}, Go to workspace ${toString ws},workspace, ${toString ws}"
              "$shiftmod, ${toString i}, Move to ${toString ws},movetoworkspace, ${toString ws}"
            ]
            # ]
          )
          10)
      );
      bind = [
        ## Weirds
        "$shiftmod, P, resizeactive, exact 700 400"

        # halp!
        "$shiftmod, code:61, exec, hypr-binds"
        "$mod, code:61, exec, hypr-binds"

        ## Groups
        "$mod, G, togglegroup"
        "$mod, Tab, cyclenext,"
        "alt, GRAVE, changegroupactive"
        "alt, 1, changegroupactive, 1"
        "alt, 2, changegroupactive, 2"
        "alt, 3, changegroupactive, 3"
        "alt, 4, changegroupactive, 4"
        "alt, 5, changegroupactive, 5"
        "alt, 6, changegroupactive, 6"
        #"$mod, M, exec, nwg-bar # show the logout window"
        "$mod, bracketleft, cyclenext, prev"
        "$mod, bracketright, cyclenext"
        # stuff

        

        ### NAVIGATION ###
        "$mod, u, focusurgentorlast # toggle between urgent or last workspaces"
        "$mod, grave, togglespecialworkspace, visor"
        "$shiftmod, grave, movetoworkspace, special, visor"
        "$mod, Escape, exec, ignis toggle-window ignis_CONTROL_CENTER"
        "$mod Alt, Escape, togglespecialworkspace, popterm"

   
        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];
      binddl = [
        ", XF86AudioMute, Mute Audio, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioRaiseVolume, Volume up, exec, swayosd-client --output-volume raise --max-volume=100"
        ", XF86AudioLowerVolume, Volume down, exec,swayosd-client --output-volume lower"
        ", XF86AudioPlay, Play/Pause, exec, playerctl play-pause"
        ", XF86AudioPrev, Previous Song, exec, playerctl previous"
        ", XF86AudioNext, Next Song, exec, playerctl next"
        ", XF86MonBrightnessUp, Raise brightness, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, Lower brightness, exec, swayosd-client --brightness lower"
        ", XF86AudioMedia, Music workspace, togglespecialworkspace, music" # Framework Key / F12
        # ", Super_L, Not Bound yet, exec, notify-send 'Not bound yet'" # fn > F9

        ### LAPTOP LID
        # trigger when the switch is turning off
        #", switch:off:Lid Switch, Laptop open,exec,hyprctl keyword monitor \"eDP-1, preferred,auto,2\""
        # trigger when the switch is turning on
        #", switch:on:Lid Switch, Laptop closes,exec,hyprctl keyword monitor \"eDP-1, disable\""
      ];
      binddm = [
        "$mod,mouse:272,Move window, movewindow # left click"
        "$mod,mouse:273,Resize window, resizewindow # right click"
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
      device = [
      {
        name = "razer-razer-naga-trinity";
        accel_profile = "adaptive";
        sensitivity = -0.8;
      }
      # {
      #   name = "wch.cn-touchscreen-1";
      #   # output = "desc:XYK Display demoset-1";
      # }
      ];
      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 3;
        "col.active_border" = "rgba(FF6700EE) rgba(FF470099) 60deg";
        "col.inactive_border" = "rgba(0098ffaa) rgba(0078EE88) 60deg";
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
        slave_count_for_center_master = 0; # old always_center_master
        center_master_fallback = "right";
        orientation = "right";
        mfact = 0.6; # 0.55 default
      };
      gesture = [
        "3, horizontal, workspace"
        #"3, down, dispatcher, overview:open"
        #"3, up, dispatcher, overview:close"
        #"3, down, mod: ALT, close"
        #"3, up, mod: SUPER, scale: 1.5, fullscreen"
        #"3, left, scale: 1.5, float"
      ];
      #gestures = {
      #  workspace_swipe = true;
      #  workspace_swipe_create_new = true;
      #  #workspace_swipe_use_r = true;
      #};
      decoration = {
        rounding=9;
        shadow = {
          enabled = true;
          # range = 10;
          # render_power = 4;
          color = "rgba(ff6700ee)"; #"rgba(1a1a1aee)";
          color_inactive = "rgba(0098ff33)";
        };
        active_opacity=0.9;
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
        #auto_group = false;
        drag_into_group = 1;
        "col.border_active" = "rgba(ff6700ee)";
        "col.border_inactive" = "rgba(0098ff33)";
        groupbar = {
          font_size = config.my.looks.font.size;
          gradients = true;
          indicator_height = 0;
          gradient_rounding = 14;
          gradient_round_only_edges = false;
          "col.active" = "rgba(ff6700ee)";
          "col.inactive" = "rgba(0098ff33)";
        };
      };
      animations = {
        enabled=true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        # https://easings.net/
        # https://www.cssportal.com/css-cubic-bezier-generator/
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "easeOutQuart, 0.25, 1, 0.5, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "easeInOutExpo, 0.87, 0, 0.13, 1"
        ];
        animation = [
          "windows, 1, 3, easeOutExpo, popin 40%"
          "border, 1, 8, easeOutExpo"
          "fade, 1, 9, easeOutQuart"
          "workspaces, 1, 5, easeOutExpo, slidefade"
          "specialWorkspace, 1, 3, easeOutExpo, slidefadevert -50%"
        ];
      };
      windowrule = [
        "animation slide left, onworkspace:special:popterm"
      ];
      windowrulev2 = [ 
        # special workspace
        "float, onworkspace:s[true]"
        "bordercolor rgba(FF6700EE) rgba(0098FF66) 60deg, onworkspace:s[true]"
        "animation slidefade -50%, onworkspace:special:popterm"
        "size 90% 80%, onworkspace:special:visor"
        "size 90% 80%, onworkspace:special:music"
        "size 35% 95%, onworkspace:special:popterm"
        "move 5 38, onworkspace:special:popterm"

        # Pin App to workspaces#
        "workspace 4 silent, class:^(discord)$"


        "tag +settings, class:(nm-tray)"
        "tag +settings, class:^(nm-connection-editor)$"
        "tag +fixsize, class:^(nm-connection-editor)$"
        "tag +settings, class:^(pavucontrol)$"
        "tag +settings, class:^(org.pulseaudio.pavucontrol)$"
        "tag +fixsize, class:^(org.pulseaudio.pavucontrol)$"
        "tag +settings, class:^(.blueman.*)$"
        #"tag +fixsize, class:^(.blueman.*)$"
        "tag +float, class:^(org.gnome.Nautilus)$"
        "tag +float, class:^(org.gnome.Calculator)$"
        # Code
        "opacity 0.95 override 0.8 override, class:^(code)$"
        # Video
        #"tag +video, class:^(mpv)$"
        "content video, class:^(mpv)$"
        #"tag +video, class:^(vlc)$"
        "content video, class:^(vlc)$"
        #"float, tag:video"
        #"opacity 1 override, tag:video"
        #"opacity 1 override, content:video"

        # Firefox
        "tag +firefox, class:^(firefox)$"
        "tag +firefox, class:^(librewolf)$"
        "opacity 1 override 0.8 override, tag:firefox"
        "tag +video,initialTitle:^(Picture-in-Picture)$"
        "content video,initialTitle:^(Picture-in-Picture)$"

        #"float,initialTitle:^(Picture-in-Picture)$"
        "size 700 400, initialTitle:^(Picture-in-Picture)$"

        # PrusaSlicer
        "opacity 1 override, initialClass:^(PrusaSlicer)$,floating:1"
        "tag +settings, initialClass:^(PrusaSlicer)$, title:Choose one (or more )\?files\?(.*)"

        
        ## Rofi
        "move cursor -3% -105%,class:^(rofi)$"
        "noanim,class:^(rofi)$"
        "opacity 0.8 override 0.6 override,class:^(rofi)$"

        ## Steam
        "tag +steam, initialClass:^(steam)$"
        "tag +steam, initialTitle:^(Steam)$"
        "noborder, floating:1, tag:steam"
        "noshadow, floating:1, tag:steam"

        ## Fusion 360
        "tag +fusion, initialClass:^(fusion360.exe)$"
        "tag +fusion, initialClass:^(steam_proton)$"
        "opacity 1 override, tag:fusion"
        "noanim, tag:fusion"
        "noblur, tag:fusion"
        "suppressevent activatefocus activate, tag:fusion"

        # FreeCAD
        "tag +freecad, initialClass:^(org.freecad.FreeCAD)$"
        "tag +freecad, initialClass:^(FreeCAD)$"
        "tag +settings, tag:freecad, title:^(Preferences)$"
        "tag +settings, tag:freecad, title:^([ a-zA-Z]* Manager)$"
        "tag +settings, tag:freecad, title:^(Location of your .*)$"
        "tag +settings, tag:freecad, title:^(.* configuration)$"
        "tag +settings, tag:freecad, title:^(KiCad.* tools)$"
        "tag +ospdialog, tag:freecad, title:^(([a-zA-Z] )?(Add|Edit|Delete) .*)$"
        "tag +ospdialog, tag:freecad, title:^((Add|Edit|Select|Updating|Export) .*)$"
        #"tag +float, tag:fixsize, tag:freecad"
        "tag +ospdialog, tag:freecad, title:^(Choose category and set a filename without extension)$"
        "tag +ospdialog, tag:freecad, title:^(Placement)$"
        "focusonactivate on, tag:freecad, floating:1, title:^(Expression editor)$"
        "opacity 1 override, tag:freecad"
        "tag +nograb, tag:freecad, floating:1"
        #"suppressevent activatefocus, tag:freecad"

        # Evolution
        "tag +evolution, initialClass:^(org.gnome.Evolution)$"
        "tag +float, initialTitle:^((Appointment|Meeting|Memo|Task) — .*)$, tag:evolution"
        "tag +fixsize, initialTitle:^((Appointment|Meeting|Memo|Task|Contact Editor) — .*)$, tag:evolution"

        # SigRok
        "tag +sigrok, initialClass:^(org.sigrok.)"
        "tag +settings, initialTitle:^(Connect to Device)$"

         ## KiCAD
        #"tag +kicad, class:^(kicad)$"
        #"opacity 1 override, tag:kicad"
        #"xray off, tag:kicad"
        #"decorate off, tag:kicad"
        #"forcergbx, tag:kicad"
        #"group invade, tag:kicad"

        ## OneDrive GUI ##
        "tag +onedrive, title:^(OneDriveGUI .*)$"
        "tag +fixsize, tag:onedrive"

        "tag +synology, initialClass:^(cloud-drive-ui)$"
        "move onscreen cursor, tag:synology"

        ## Signal
        "tag +float, initialClass:^(signal)$"
        "tag +fixsize, initialClass:^(signal)$"
        "size 70% 70%, initialClass:^(signal)$"


        ### 1Password
        #"float, class:^(1Password)$"
        "tag +security, class:^(1Password)$, title:(Lock Screen — 1Password)"
        "stayfocused, class:^(1Password)$, title:(Quick Access)"
        "center 1, class:^(1Password)$, title:(Quick Access)"
        #"tag +1password, class:^(1Password)$, title:^((?!Quick Access).)*$"
        "tag +1password, class:^(1Password)$"
        "tag +1password, class:^(1password)$"
        #"tag -1password, title:^(Quick Access.*)$"
        #"tag -1password, title:^((?!Quick Access).)*$"
        "float, tag:1password"
        "size 70% 70%, tag:1password"
        "center 1, tag:1password"
        #"animation popin, tag:1password"


        ### Open/Save Dialogs ###
        #"tag +ospdialog, class:xdg-desktop-portal-gtk, title:(Enter name of ([a-zA-Z]*) to (open|save to))"
        #"tag +ospdialog, class:xdg-desktop-portal-gtk, title:(Overwrite (.*)\?)"
        "tag +ospdialog, class:xdg-desktop-portal-gtk"
        "tag +ospdialog, title:^((Open|Save|File|Select|Import) ([a-zA-Z]*)( [a-zA-Z]*)\?)$"
        "tag +ospdialog, title:^((Print) ([a-zA-Z]*)( [a-zA-Z]*)\?)$"
        "tag +ospdialog, title:^(Print)$"

        

        ### Quick View #
        "tag +quickview, class:org.gnome.NautilusPreviewer"
        "bordercolor rgba(FF6700EE) rgba(0098FF66) 60deg, tag:quickview"
        "size 80%, tag:quickview"
        "float, tag:quickview"
        "center 1, tag:quickview"

        ### Security ###
        "tag +security, initialClass:^(org.gnupg.pinentry.*)"
        "tag +security, class:^(pinentry-)"
        "tag +security, initialClass:^(gcr-prompter)$"
        "tag +security, initialTitle:^(Hyprland Polkit Agent)$"
        "stayfocused, tag:security # fix pinentry losing focus"
        "bordercolor rgba(E60000AA), tag:security"

        ## Settings
        "tag +settings, class:^(dev.deedles.Trayscale)$"
        "tag +settings, class:^(se.grenangen.)$"
        "tag +settings, class:^(org.gnome.NetworkDisplays)$"
        #"tag +settings, initialTitle:^(Tail Tray)$"
        "maxsize 1200 850, initialTitle:^(Tail Tray)$"
        "float, tag:settings"
        "center 1, tag:settings"
        "size >70% >70%, tag:settings"
        "maxsize 1200 850, tag:settings"
        "minsize 800 600, tag:settings"
        #"size 1000 800, tag:settings"

        ## Tag Actions, Generic
        "float, tag:float"
        "size 80% 80%, tag:fixsize, match:float"
        #"size 1000 700, tag:fixsize"
        "center 1, tag:fixsize, match:float"
        #"maxsize 1200 850, tag:fixsize"
        #"minsize 800 600, tag:fixsize"
        "stayfocused, tag:keepfocus"

        "float, tag:ospdialog"
        "size 70% 70%, tag:ospdialog"
        "center 1, tag:ospdialog"
        "bordercolor rgba(FF6700EE) rgba(0098FF66) 60deg, tag:ospdialog"
        #"stayfocused,tag:ospdialog"

        "opacity 1 override, content:video"
        "suppressevent activatefocus, content:video"
        "suppressevent activatefocus, tag:video"
        "float, content:video"
        "float, tag:video"

        "suppressevent activatefocus, tag:nograb"
      ];
    };
    wayland.windowManager.hyprland.extraConfig = ''
        # will switch to a submap called resize
        bindd=ALT, R, Enter the resize submap, submap, resize

        # will start a submap called "resize"
        submap=resize

        # sets repeatable binds for resizing the active window
        binde=, right, resizeactive,10 0
        binde=, left, resizeactive,-10 0
        binde=, up, resizeactive,0 -10
        binde=, down, resizeactive,0 10
        binde=, Prior, layoutmsg,mfact +0.01
        binde=, Next, layoutmsg, mfact -0.01

        bindm=,mouse:272,movewindow
        bindm=,mouse:273,resizewindow

        # use reset to go back to the global submap
        bind=,escape,submap,reset 

        # will reset the submap, which will return to the global submap
        submap=reset

        # keybinds further down will be global again...

        plugin {
          overview {
            affectStrut = false
            autoDrag = true
            autoScroll = true
            centerAligned = true
            panelBorderWidth = 5
            panelHeight = 200
            dragAlpha = 0.5
            showEmptyWorkspace = true
            showNewWorkspace = true
            workspaceActiveBorder = rgba(FF6700EE) 
            workspaceInactiveBorder = rgba(0098FFAA) 
          }
        }
        #source = ~/.config/hypr/local.conf
    '';

  };
}
