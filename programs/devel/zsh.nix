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
    completionInit = ''
      # CompInit: {{{
      autoload -Uz compinit
      for dump in ${config.xdg.configHome}/zsh/.zcompdump(N.mh+24); do
        echo "comp init"
        compinit -d ${config.xdg.configHome}/zsh/.zcompdump
      done
      compinit -C
      # }}}
    '';
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
    zprof.enable = false;
    sessionVariables = {
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
    shellAliases = {
      ls = "ls -F --color=auto";
    };
    initExtraFirst = ''
      # FIRST!
    '';
    initExtraBeforeCompInit = ''
      #setopt print_exit_value
      skip_global_compinit=1
    '';
    initExtra = ''
      # initExtra: {{{
      # see man zshoptions(1)
      setopt INC_APPEND_HISTORY
      setopt PRINT_EXIT_VALUE
      setopt TRANSIENT_RPROMPT
      setopt ALWAYS_TO_END
      setopt AUTO_MENU # Cycle through possibilities during tab completion.
      setopt AUTO_PUSHD # Automatically append to the stack.
      setopt COMPLETE_IN_WORD # Completion matches text to the left of the cursor when mid-word.
      setopt NO_FLOW_CONTROL
      setopt NO_CDABLE_VARS

      #setopt print_exit_value
      #setopt transientrprompt # only have the rprompt on the last line
      #setopt always_to_end
      #setopt auto_cd # Typing the name of a subdirectory of the CWD (or in cdpath) will go there.
      #setopt auto_menu # Cycle through possibilities during tab completion.
      #setopt auto_pushd # Automatically append to the stack.
      #setopt complete_in_word # Completion matches text to the left of the cursor when mid-word.
      #setopt correct # Correct spelling as needed. Update cache with 'hash -r'.
      #setopt extended_glob
      #setopt glob_complete
      #setopt interactive_comments # Allow comments in the interactive shell.
      #setopt list_packed
      #setopt list_types
      #setopt long_list_jobs
      #setopt magic_equal_subst
      #setopt noequals
      #setopt nonomatch
      #setopt multibyte
      #setopt NO_c_bases
      #setopt NO_complete_aliases
      #setopt NO_hup
      #setopt NO_list_rows_first
      #setopt NO_numeric_glob_sort
      #setopt NO_path_dirs
      #setopt null_glob
      #setopt pushd_ignore_dups # Ignore duplicate directories in the stack.
      #setopt pushd_minus # Reverse the meaning of +/- after pushing the CWD.
      #setopt pushd_to_home # With no arguments act like 'pushd $HOME'.
      #setopt pushdsilent
      #setopt rc_quotes

      unsetopt flow_control
      bindkey -e #emacs mode


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

      #alias ssh="assh wrapper ssh --"

      export MANPATH="$MANPATH:$HOME/.config/man"
      #export MANSECT="1:n:l:8:3:2:3posix:3pm:3perl:5:4:9:6:7:um"
      export MANSECT="1:n:l:8:3:0:2:5:4:9:6:7:um"


      ## Prompt Stuff: {{{
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
      #{ 
      #  name = "options";
      #  file = "options.zsh";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "cnf";
      #    repo = "zshrc";
      #    rev = "ebb9381";
      #    #sha256 = "sha256-xpvw1OXJEROsnwHAMi/t4CS0/4aToHv62p/qjDyoMTg=";
      #    sha256 = "sha256-+877OI9BFFvdN6H4rmravYUinhBe2WosVSCVCzx28EE=";
      #  };
      #}
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
