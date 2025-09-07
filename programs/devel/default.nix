{ pkgs, inputs, unstable, ... }: {
  imports = [ 
    ./ballisticpinball.nix
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
    espflash

    linuxPackages.usbip
    usbip-ssh
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
