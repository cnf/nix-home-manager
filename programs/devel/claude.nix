{ lib, config, pkgs, ... }: {
  options = {
    my.claude.enable = lib.mkEnableOption "Enable and configure claude";
  };
  config = lib.mkIf config.my.claude.enable {
    home.packages = with pkgs;[
      unstable.claude-code
    ];
    # services.ollama = {
    #   enable = true;
    #   acceleration = "rocm";
    # };
  };
}
