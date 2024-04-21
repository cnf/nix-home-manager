{lib, pkgs, ...}:
let
  fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = ''
      " General Config: {{{
      "set nocompatible   " Disable vi-compatibility
      "set laststatus=2   " Always show the statusline
      "set encoding=utf-8 " Necessary to show unicode glyphs
      "set timeoutlen=250

      "set backspace=2    " make backspace work in insert mode
      " }}}
      " Show Syntax Colors: {{{
      syntax enable
      set t_Co=256 "enable 256 colors
      set background=dark
      color pointless
      " }}}
      " Code Folding: {{{
      set foldmethod=syntax   "fold based on syntax
      set foldnestmax=1       "deepest fold is 1 levels
      set foldenable        "dont fold by default
      " set foldlevel=1         "this is just what i use
      nnoremap zz zMzO
      " }}}
    '';
    plugins = with pkgs.vimPlugins; [
      airline
      sleuth
      ale
      tcomment_vim
      gitgutter
      vim-nix
      (fromGitHub "482a30223f322b6d4e569640ec979946ec873c18" "master" "cnf/vim-pointless")
    ];
  };
}
