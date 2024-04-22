{ lib, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    #syntaxHighlighting.enable = true;
    #dotDir = "${config.home.homeDirectory}/.zsh";
    history = {
      size = 10000;
      ignoreDups = true;
      ignoreAllDups = false;
      ignoreSpace = true;
      expireDuplicatesFirst = false;
      share = true;
      extended = false;
    };
    initExtraFirst = ''
      # see man zshoptions(1)
      setopt PRINT_EXIT_VALUE
      setopt TRANSIENT_RPROMPT
      setopt ALWAYS_TO_END
      setopt AUTO_MENU
      setopt AUTO_PUSHD
      setopt COMPLETE_IN_WORD
      setopt NO_FLOW_CONTROL
    '';
    #setOptions = [
    #  "HIST_IGNORE_DUPS" in history
    #  "SHARE_HISTORY" in history
    #  "HIST_FCNTL_LOCK" auto, in history
    #  "PRINT_EXIT_VALUE"
    #  "TRANSIENT_RPROMPT"
    #  "ALWAYS_TO_END"
    #  "AUTO_MENU"
    #  "AUTO_PUSHD"
    #  "COMPLETE_IN_WORD"
    #  "NO_FLOW_CONTROL"
    #];
    sessionVariables = {
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
    shellAliases = {
      ls = "ls -F --color=auto";
    };
    initExtra = ''
      watch=(notme)
      eval "$(/usr/bin/env dircolors -b)"
      export CLICOLOR=1
      if [[ -f "$HOME/.zsh/local.zsh" ]]; then
        source "$HOME/.zsh/local.zsh"
      fi
    '';
    # check vcs_info for prompt
    plugins = [
      { 
        name = "git-prompt";
        file = "lib/git.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "cnf";
          repo = "zshrc";
          rev = "ebb9381";
          #sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
          sha256 = "sha256-+877OI9BFFvdN6H4rmravYUinhBe2WosVSCVCzx28EE=";
        };
      }
      { 
        name = "prompt";
        file = "prompt.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "cnf";
          repo = "zshrc";
          rev = "ebb9381";
          #sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
          sha256 = "sha256-+877OI9BFFvdN6H4rmravYUinhBe2WosVSCVCzx28EE=";
        };
      }
      { 
        name = "options";
        file = "options.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "cnf";
          repo = "zshrc";
          rev = "ebb9381";
          #sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
          sha256 = "sha256-+877OI9BFFvdN6H4rmravYUinhBe2WosVSCVCzx28EE=";
        };
      }
      { 
        name = "dotenv";
        file = "plugins/dotenv/dotenv.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "3427da4";
          sha256 = "sha256-h8yZnFBcpSey8/Gxr630Pl08cJEeQeP+3Hpl8QrNFvU=";
        };
      }
    ]; 
  };
}
