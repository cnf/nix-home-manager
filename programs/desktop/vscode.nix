{ pkgs, unstable, lib, config, inputs, ... }:
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
      direnv
      python3
      #gcc
      clang
    ];
  };
}
