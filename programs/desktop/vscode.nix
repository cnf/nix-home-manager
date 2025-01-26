{ pkgs, unstable, lib, config, ... }:
{
  options = { 
    my.vscode.enable = lib.mkEnableOption "Enable VSCode";
  };
  config = lib.mkIf config.my.vscode.enable {
    programs.vscode = {
      enable = true;
      #package = unstable.vscode.fhs;
      package = unstable.vscode.fhsWithPackages (ps: with ps; [ direnv python3 clang zlib openssl.dev pkg-config ]);
    };
    home.packages = with pkgs; [
      # nixd # in devel/default.nix
      # nixfmt # in devel/default.nix
      # nixpkgs-fmt
      #gcc
      #rnix-lsp
      clang
      direnv
      python3
    ];
  };
}
