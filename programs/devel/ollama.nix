{ lib, config, ... }: {
  options = {
    my.ollama.enable = lib.mkEnableOption "Enable and configure ollama";
  };
  config = lib.mkIf config.my.ollama.enable {
    # services.ollama = {
    #   enable = true;
    #   acceleration = "rocm";
    # };
  };
}