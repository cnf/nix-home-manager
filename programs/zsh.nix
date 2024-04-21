{ lib, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #syntaxHighlighting.enable = true;
    #dotDir = "${config.home.homeDirectory}/.zsh";
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
      setopt print_exit_value
      eval "$(/run/current-system/sw/bin/dircolors -b)"
      export CLICOLOR=1
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
          sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
        };
      }
      { 
        name = "prompt";
        file = "prompt.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "cnf";
          repo = "zshrc";
          rev = "ebb9381";
          sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
        };
      }
      { 
        name = "options";
        file = "options.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "cnf";
          repo = "zshrc";
          rev = "ebb9381";
          sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
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
