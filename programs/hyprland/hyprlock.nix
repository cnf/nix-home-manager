{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprlock = {
      enable = true;
      sourceFirst = true;
  
      settings = {
        "$primary" = "rgb(ff6700)";
        "$primaryAlpha" = "ff6700";

        "$accent" = "rgb(0098ff)";
        "$accentAlpha" = "0098ff";

        "$text" = "rgb(cad3f5)";
        "$textAlpha" = "cad3f5";

        "$surface" = "rgb(363a4f)";
        "$surfaceAlpha" = "363a4f";

        "$font" = "JetBrains Mono Regular";
        general = {
          enable_fingerprint = true;
          fingerprint_ready_message = "Scan finger to unlock";
          fingerprint_present_message = "Removing fingerprints, please stay still";
          disable_loading_bar = false; #true
          hide_cursor = true;
        };
        background = {
          monitor = "";
          path = "$HOME/wallpaper.jpg";
          blur_passes = 2;
          color = "$primary";
        };
        label = [
        {
          monitor = "";
          text = "cmd[update:30000] echo \"$(date +\"%R\")\"";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-130, -100";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }
        {
          monitor = "";
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "-130, -250";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }
        ];
        input-field = [
        {
          monitor = "";
          size = "300, 70";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$primary";
          inner_color = "$surface";
          font_color = "$text";
          fade_on_empty = true;
          placeholder_text = ''<span foreground="##$textAlpha"> <i>Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
          hide_input = false;
          check_color = "$accent";
          fail_color = "rgb(FF0000)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "rgb(ff0000)";
          position = "0, -185";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
        }
        ];
      };
    };
  };
}

