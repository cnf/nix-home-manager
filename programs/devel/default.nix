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
    gnumake
    nil
    nixd
    nixfmt-rfc-style

    gum

    bustle
    httpie
    remarshal
    dysk

    gdb
    sqlite-interactive

    rpi-imager

    linuxPackages.usbip
    usbip-ssh
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
