{ pkgs, inputs, unstable, ... }: {
  imports = [ 
    ./ballisticpinball.nix
    ./debuggers.nix
    ./git.nix 
    ./golang.nix 
    ./neovim.nix 
    ./ollama.nix
    ./tio.nix
    ./zsh.nix
  ];

  programs.direnv.enable = true;
  home.packages = with unstable; [ 
    gnumake
    nil
    nixd
    nixfmt

    gum

    httpie
    remarshal
    dysk

    dfu-util

    sqlite-interactive

    rpi-imager
    rpiboot

    linuxPackages.usbip
    usbip-ssh
  ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
