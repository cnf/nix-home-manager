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
      MANSECT="1:n:l:8:3:0:2:5:4:9:6:7:um";
      MANPAGER=''sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman' '';
      #MANPAGER=''sh -c 'col -bx | bat -lman -p' '';
      #MANPAGER="nvim -c 'Man!' -o -"
      #MANPAGER=''most'';
      #GROFF_NO_SGR=1;
      #COLORTERM="truecolor";  
      #MOST_INITFILE=".config/most/most.rc";
      #LESS_TERMCAP_mb=''$'\e[01;31m' '';       # begin blinking
      #LESS_TERMCAP_md=''$'\e[01;37m' '';       # begin bold
      #LESS_TERMCAP_me=''$'\e[0m' '';           # end all mode like so, us, mb, md, mr
      #LESS_TERMCAP_se=''$'\e[0m' '';          # end standout-mode
      #LESS_TERMCAP_so=''$'\e[45;93m' '';       # start standout mode
      #LESS_TERMCAP_ue=''$'\e[0m' '';          # end underline
      #LESS_TERMCAP_us=''$'\e[4;93m' '';       # start underlining
    };
    xdg.configFile."most/most.rc".text = ''
      % Color settings

      color normal lightgray black
      color status blue black
      color underline brightgreen black
      color overstrike brightred black

    '';
  };
}
