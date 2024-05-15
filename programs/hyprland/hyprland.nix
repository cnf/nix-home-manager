{ pkgs, lib, config, inputs, unstable, ... }:

{
  #options = {
  #  my.hyprland.enable = lib.mkEnableOption "Enable and configure hyprland";
  #};
  config = lib.mkIf config.my.hyprland.enable {
    my.desktop.enable = true;
    home.packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      pavucontrol
      blueman
     # polkit-kde-agent < TODO
      kitty
      wev
    ];

    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;

    wayland.windowManager.hyprland.enable  = true;
    #wayland.windowManager.hyprland.plugins  = [
    #  inputs.hyprgrass.packages.${pkgs.system}.default
    #  "horriblename/hyprgrass"
    #];
    wayland.windowManager.hyprland.settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        ",preferred,auto,1"
        "desc:XYK Display demoset-1,preferred,auto,1"
      ];
      exec-once = [
        "waybar"
        "dunst"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store #Stores only text data"
        "wl-paste --type image --watch cliphist store #Stores only image data"
        ""
      ];
      "$mod" = "SUPER";
      # $wob_socket        = $XDG_RUNTIME_DIR/wob.sock # Used like $wob_socket <number>
      "$sink_volume" = "pactl get-sink-volume @DEFAULT_SINK@ | grep '^Volume:' | cut -d / -f 2 | tr -d ' ' | sed 's/%//'";
      "$sink_volume_mute" = "pactl get-sink-mute @DEFAULT_SINK@ | sed -En \"/no/ s/.*/$($sink_volume)/p; /yes/ s/.*/0/p\"";

      env = [
        "XCURSOR_SIZE,24"]

      ;
      misc.disable_hyprland_logo=true;

      bind = [
        "$mod, F4, killactive, # close the active window"
        "$mod, L, exec, hyprlock #lock the active window"
        #"$mod, M, exec, wlogout --protocol layer-shell # show the logout window"
        "$mod, M, exec, nwg-bar # show the logout window"
        #"$mod, M, exit,"
        "$mod SHIFT, M, exit, # Exit Hyprland all together no (force quit Hyprland)"
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, V, togglefloating, # Allow a window to float"
        "$mod, SPACE, exec, rofi -show drun # Show the graphical app launcher"
        #"$mod, SPACE, exec, anyrun"
        "ALT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy # open clipboard manager"
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
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 0"
        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        # halp!
        "$mod SHIFT, code:61, exec, $HOME/.config/hypr/keys.sh"
        "$mod, code:61, exec, $HOME/.config/hypr/keys.sh"

      ];
      binde = [
        #", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5% && $sink_volume > $wob_socket"
        #", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5% && $sink_volume > $wob_socket"
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ];
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
      input = {
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        touchpad.natural_scroll = "yes";
        kb_options = "ctrl:nocaps";
      };
      general = {
        "gaps_in" = 5;
        "gaps_out" = 5;
        "border_size" = 2;
        "col.active_border" = "rgba(ff6100ee) rgba(0098ffee) 50deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
      };
      dwindle = {
        pseudotile = "yes #master switch for pseudoriling. Enabling is bound to mod+P";
        preserve_split = "yes";
      };
      master = {
        new_is_master = "true";
        orientation = "right";
      };
      gestures = {
        workspace_swipe = true;
      };
      decoration = {

        blur = {
          enabled=true;
          size=7;
          passes=4;
          new_optimizations=true;
        };
        rounding=5;
        active_opacity=0.9;
        inactive_opacity=0.7;
        drop_shadow=true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
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
        hyprbars {
        # example config
        bar_height = 20

        # example buttons (R -> L)
        # hyprbars-button = color, size, on-click
        hyprbars-button = rgb(ff4040), 10, 󰖭, hyprctl dispatch killactive
        hyprbars-button = rgb(eeee11), 10, , hyprctl dispatch fullscreen 1
        }
        }
      '';

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };

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
