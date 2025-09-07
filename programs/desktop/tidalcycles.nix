{ lib, config, pkgs, unstable, inputs, ... }:

{
  options = {
    my.tidalcycles.enable = lib.mkEnableOption "Enable and configure Tidal Cycles";
  };
  config = lib.mkIf config.my.tidalcycles.enable {
    home.packages = [
      inputs.tidalcycles.packages.${pkgs.stdenv.hostPlatform.system}.default
      unstable.ihaskell
      unstable.haskellPackages.tidal
      #unstable.supercollider-with-plugins
      unstable.supercollider-with-sc3-plugins
    ];
  };
}
