{ pkgs, lib, config, ... }:
let
  # https://wiki.nixos.org/wiki/NixOS_Generations_Trimmer
  trim-generations = pkgs.stdenv.mkDerivation {
    name = "trim-generations";
    src = pkgs.fetchurl {
      url = "https://gist.githubusercontent.com/MaxwellDupre/3077cd229490cf93ecab08ef2a79c852/raw/ccb39ba6304ee836738d4ea62999f4451fbc27f7/trim-generations.sh";
      hash = "sha256-kIWTg8FSpNtDyEFr4/I54+GpGjiV2zWPO6WZQU4gEZ8=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      install -Dm755 $src $out/bin/trim-generations.sh
    '';
  };
in 

{
  options = {
    my.helpers.enable = lib.mkEnableOption "Various helper scripts" // {default = true;};
  };
  config = lib.mkIf config.my.helpers.enable {
    #nixpkgs.config.allowUnfreePredicate = pkg: 
    #  builtins.elem (lib.getName pkg) ["gitkraken"];

    home.packages = [
      trim-generations
    ];
  };
}
