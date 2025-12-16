{ pkgs, unstable, lib, config, ... }:
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
  options = {
    my.vim.enable = lib.mkEnableOption "Enable and configure NeoVim";
  };
  config = lib.mkIf config.my.vim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      extraLuaConfig = ''

        -- Extra Lua Config
        -- NIXD
        vim.lsp.enable('nixd')
        vim.lsp.config('nixd', {
          cmd = { "nixd" },
          settings = {
              nixd = {
                nixpkgs = {
                    expr = "import <nixpkgs> { }",
                },
                formatting = {
                    command = { "nixfmt" },
                },
                options = {
                    -- nixos = {
                    --   expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
                    -- },
                    home_manager = {
                      expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."cnf@hydra".options',
                    },
                },
              },
          },
        })
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      '';
      extraConfig = ''
        " General Config: {{{
        set nocompatible   " Disable vi-compatibility
        set laststatus=2   " Always show the statusline
        set encoding=utf-8 " Necessary to show unicode glyphs
        set timeoutlen=250

        set backspace=2    " make backspace work in insert mode
        " }}}
        " Indenting Defaults: {{{
        set expandtab
        set tabstop=4
        set shiftwidth=4
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
      extraPackages = with pkgs; [
        ripgrep
      ];
      plugins = with pkgs.vimPlugins; [
        airline
        sleuth
        ale
        tcomment_vim
        gitgutter
        vim-nix
        unstable.vimPlugins.cspell-nvim
        nvim-lspconfig
        (fromGitHub "482a30223f322b6d4e569640ec979946ec873c18" "master" "cnf/vim-pointless")
      ];
    };
  };
}
