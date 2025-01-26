{ pkgs, inputs, unstable, ... }: {
  imports = [ 
    ./git.nix 
    ./golang.nix 
    ./neovim.nix 
    ./zsh.nix
  ];

  programs.direnv.enable = true;
  home.packages = with pkgs; [ 
    nil
    nixd
    nixfmt-rfc-style
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
