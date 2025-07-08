{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.man.enable = lib.mkEnableOption "Install man pages stuff";
  };
  config = lib.mkIf config.my.man.enable {
    home.packages = with pkgs; [
      #wikiman
      most
    ];
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
      config = {
        theme = "Monokai Extended";
        #italic-text="always";
      };
    };
    programs.tealdeer.enable = true;
    programs.tealdeer.settings.updates.auto_update = true;
    home.sessionVariables = {
      MANPAGER=''sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman' '';
      #MANPAGER=''sh -c 'col -bx | bat -lman -p' '';
      MANSECT="1:n:l:8:3:0:2:5:4:9:6:7:um";
    };
  };
}
