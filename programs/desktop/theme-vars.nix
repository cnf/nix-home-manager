{ pkgs, unstable, lib, ... }:
with lib;
let
  tokyo-night-gtk-orange = pkgs.tokyo-night-gtk.override {
            themeVariants = ["orange" "default"];
          };
in
{
  options = {
    my.looks = {
      font = {
        name = mkOption {default = "Inter";};
        size = mkOption {default = 11;};
        emoji = mkOption {default = ["Noto Color Emoji"];};
        serif = mkOption {default = ["DejaVu Serif"];};
        sansSerif = mkOption {default = ["Inter" "JetBrainsMono Nerd Font"];};
        monospace = mkOption {default = ["SauceCodePro Nerd Font" "Source Code Pro" "FRB Cistercian"];};
      };
      cursor = {
        name = mkOption {default = "Nordzy-cursors";};
        package = mkOption {default = pkgs.nordzy-cursor-theme;};
        size = mkOption {default = 24;};
      };
      theme = {
        gtk = {
          name = mkOption {default = "Tokyonight-Orange-Dark";};
          package = mkOption {default = tokyo-night-gtk-orange; };
          extraCss = mkOption{default = builtins.readFile ./gtk.css;};
        };
        qt = {
        };
      };
      icons = {
        name = mkOption {default = "kora";};
        package = mkOption {default = pkgs.kora-icon-theme;};
      };
      colors = {
        primary = mkOption {default = "rgb(FF6700)";};
        primaryAlpha = mkOption{ default ="rgba(FF6700FF)";};
        accent = mkOption {default = "rgb(0098FF)";};
        accentalpha = mkOption {default = "rgba(0098FFAA)";};
        text = mkOption {default = "rgb(FFFFFF)";};

      };
    };
  };
}

#@define-color bgcolor #323232;
#@define-color bgaccent #525262;
#@define-color primary #ff8514; 
#@define-color accent #148eff;
#@define-color textcolor white;
#@define-color isok #32d74b;
#@define-color notice #ffd60a;
#@define-color warning #ffa914;
#@define-color critical #ff4f44;
#"$primary" = "rgb(ff6700)";
#"$primaryAlpha" = "ff6700";

#"$accent" = "rgba(0098FFAA)";
#"$accentAlpha" = "0098ff";

#"$text" = "rgb(cad3f5)";
#"$textAlpha" = "cad3f5";

#"$surface" = "rgb(363a4f)";
#"$surfaceAlpha" = "363a4f";

