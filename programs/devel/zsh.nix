{ pkgs, lib, config, inputs, ... }:

{
  options = {
    my.zsh.enable = lib.mkEnableOption "Enable and configure zsh";
  };
  config = lib.mkIf config.my.zsh.enable {
    #programs.nix-your-shell.enable = true;
    programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
    history = {
      append = false;
      expireDuplicatesFirst = false;
      extended = true;
      ignoreAllDups = false;
      ignoreDups = true;
      ignoreSpace = true;
      path = "$HOME/.local/zsh/history";
      share = false;
      size = 10000;
    };
    sessionVariables = {
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
    shellAliases = {
      ls = "ls -F --color=auto";
    };
    initExtraBeforeCompInit = ''
      setopt print_exit_value
    '';
    initExtra = ''
      # initExtra: {{{
      # see man zshoptions(1)
      setopt INC_APPEND_HISTORY
      setopt PRINT_EXIT_VALUE
      setopt TRANSIENT_RPROMPT
      setopt ALWAYS_TO_END
      setopt AUTO_MENU
      setopt AUTO_PUSHD
      setopt COMPLETE_IN_WORD
      setopt NO_FLOW_CONTROL

      # notify when someone else logs in
      watch=(notme)

      # ls dircolors
      eval "$(/usr/bin/env dircolors -b)"
      export CLICOLOR=1

      # load local config not in git
      if [[ -f "$HOME/.config/zsh/local.zsh" ]]; then
        source "$HOME/.config/zsh/local.zsh"
      fi

      # kitty ssh fix
      #[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh" 
      [[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitten ssh" 

      ## Prompt Stuff
      typeset +x PS1

      if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        SESSION_TYPE=remote
      else
        case $(ps -o comm= -p "$PPID") in
          sshd|*/sshd) SESSION_TYPE=remote;;
        esac
      fi

      if [ $UID -eq 0 ]; then
        user="%B%F{red}%m%f%b"
        symbol='#'
      elif [[ "$SESSION_TYPE" == "remote" ]]; then
        user="%B%F{cyan}%m%f%b"
        symbol='$'
      else
        user="%B%F{green}%m%f%b"
        symbol='$'
      fi

      function rsymbol {
        git branch >/dev/null 2>/dev/null && echo "%B%F{yellow}±" && return
        [ -d .svn ] && echo "%B%F{yellow]%}⨰" && return
        echo $symbol
      }

      function venv {
        [ $VIRTUAL_ENV ] || return
        # echo " %B%F{cyan}$(basename $\{VIRTUAL_ENV\} | tr '[A-Z]' '[a-z]')%f%b"
        echo "  %B%F{cyan}''${VIRTUAL_ENV##*/}%f%b%k"
      }

      function nixshell {
        [ $IN_NIX_SHELL ] || return
        echo " 󱄅 %B%F{cyan}''${IN_NIX_SHELL}%f%b%k"
      }

      ZSH_THEME_GIT_PROMPT_PREFIX="⟮"
      ZSH_THEME_GIT_PROMPT_SUFFIX="⟯"
      ZSH_THEME_GIT_PROMPT_SEPARATOR="⸽"
      ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[yellow]%}"
      ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%} ⟳"
      ZSH_THEME_GIT_PROMPT_UPSTREAM_NO_TRACKING="%{$fg_bold[red]%}!"
      ZSH_GIT_PROMPT_SHOW_UPSTREAM=symbol
      ZSH_GIT_PROMPT_SHOW_STASH=1
      typeset +x PS1




      setopt PROMPT_SUBST
      PROMPT='%f%b$user %B%F{blue}%2~ $(rsymbol)%f%b '
      RPROMPT='%f%b$(gitprompt)%f%b$(gitprompt_secondary)%f%b$(nixshell)%f%b$(venv) $(battery_pct_prompt)%f%b'
      SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
      export VIRTUAL_ENV_DISABLE_PROMPT=1 # we have our own on the right prompt
      # }}}
    '';
    antidote = {
      enable = true;
      plugins = [
        "ohmyzsh/ohmyzsh path:plugins/battery"
        "ohmyzsh/ohmyzsh path:plugins/dotenv"
        "woefe/git-prompt.zsh"
      ];
    };
    # check vcs_info for prompt
    plugins = [
      #{ 
      #  name = "git-prompt";
      #  file = "lib/git.zsh";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "cnf";
      #    repo = "zshrc";
      #    rev = "ebb9381";
      #    #sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
      #    sha256 = "sha256-+877OI9BFFvdN6H4rmravYUinhBe2WosVSCVCzx28EE=";
      #  };
      #}
      #{ 
      #  name = "prompt";
      #  file = "prompt.zsh";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "cnf";
      #    repo = "zshrc";
      #    rev = "ebb9381";
      #    #sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
      #    sha256 = "sha256-+877OI9BFFvdN6H4rmravYUinhBe2WosVSCVCzx28EE=";
      #  };
      #}
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
};
}
