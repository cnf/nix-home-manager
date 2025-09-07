{ lib, config, pkgs, ... }: {
  options = {
    my.ballisticpinball.enable = lib.mkEnableOption "Ballistic Pinball Dev Stuff";
  };
  config = lib.mkIf config.my.ballisticpinball.enable {
    home.packages = with pkgs;[
      liblo

      python3Packages.oscpy
    ];
    # services.ollama = {
    #   enable = true;
    #   acceleration = "rocm";
    # };
  };
}
