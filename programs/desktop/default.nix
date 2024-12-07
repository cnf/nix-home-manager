{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = { 
    my.desktop.enable = lib.mkEnableOption "Enable a graphical env";
  };
  imports = [
    ./vscode.nix
    ./firefox.nix
    ./obsidian.nix
    ./discord.nix
    ./mqtt.nix
  ];
  config = lib.mkIf config.my.desktop.enable {
    fonts.fontconfig.enable = true;
    programs.jq.enable = true;
    home.packages = with pkgs; [
      unstable._1password-cli
      unstable._1password-gui
      # audio
      pavucontrol
      pulseaudio

      # notification tools
      libnotify

      # fonts
      source-code-pro
      font-awesome
      liberation_ttf
      mplus-outline-fonts.githubRelease
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      proggyfonts

      spotify
    ];
  };
}
