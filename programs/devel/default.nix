{ pkgs, inputs, unstable, ... }: {
  imports = [ 
    ./tio.nix
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

    gum

    bustle
    httpie

    gdb
    sqlite-interactive

    rpi-imager
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
