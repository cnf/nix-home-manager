{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.desktop.enable = lib.mkEnableOption "Enable a graphical env";
  };
  config = lib.mkIf config.my.desktop.enable {
    fonts.fontconfig.enable = true;
    programs.jq.enable = true;
    home.packages = with pkgs; [
      # audio
      pavucontrol
      pulseaudio

      # notification tools
      libnotify

      # fonts
      font-awesome
      liberation_ttf
      mplus-outline-fonts.githubRelease
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      proggyfonts
    ];
  };
}
