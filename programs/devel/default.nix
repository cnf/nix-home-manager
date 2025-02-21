{ pkgs, inputs, unstable, ... }: {
  imports = [ 
    ./git.nix 
    ./golang.nix 
    ./neovim.nix 
    ./zsh.nix
    ./ollama.nix
  ];

  programs.direnv.enable = true;
  home.packages = with unstable; [ 
    nil
    nixd
    nixfmt-rfc-style

    bustle
    httpie

    gdb
    sqlite-interactive
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
