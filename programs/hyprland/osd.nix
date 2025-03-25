{ pkgs, lib, config, inputs, unstable, ... }:

{
  config = lib.mkIf config.my.hyprland.enable {
    #home.packages = with pkgs; [
    #  swayosd
    #  wob
    #];
    services.swayosd.enable = true;
    xdg.configFile."swayosd/style.css".text = ''
      window#osd {
        padding: 12px 20px;
        border-radius: 999px;
        border: none;
        background: rgba(78, 78, 94, 0.85);
      }

      #container {
        margin: 16px;
      }

      image,
      label {
        color: rgba(205, 214, 244, 0.9);
      }

      progressbar:disabled,
        image:disabled {
        opacity: 0.4;
      }

      progressbar {
        min-height: 6px;
        border-radius: 999px;
        background: transparent;
        border: none;
      }
      trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: rgba(205, 214, 244, 0.4);
      }
      progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: rgba(205, 214, 244, 0.95);
      }
    '';
    #services.wob.enable = true;
  };
}
