{ pkgs, lib, config, inputs, ... }:
{
  options = { 
    my.nixtools.enable = lib.mkEnableOption "Install nix specific dev/search/... tools";
  };
  config = lib.mkIf config.my.nixtools.enable {
    home.packages = with pkgs; [
      nix-inspect
      nix-output-monitor #purrdy alternative to nix commands
      nvd # compare generations
    ];
    programs.nh.enable = true; # yet another Nix CLI helper.
    #programs.nix-index.enable = true; # look for packages containing a command.
    #programs.command-not-found.enable = lib.mkIf config.programs.nix-index.enable false;
  };
}
