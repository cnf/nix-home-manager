{ pkgs, unstable, lib, config, inputs, ... }:
{
  options = {
    my.tryouts.enable = lib.mkEnableOption "Things I am trying out";
  };
  config = lib.mkIf config.my.tryouts.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: 
      builtins.elem (lib.getName pkg) ["gitkraken"];

    home.packages = with pkgs; [
      graphia
      unstable.gitkraken
      unstable.gk-cli

      git-backup-go
      github-backup
      git-stack
      git-gone

    ];
  };
}
