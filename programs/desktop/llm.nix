{ lib, config, pkgs, unstable, inputs, ... }: 
let
  my-hermes-agent = inputs.hermes-agent.packages.${pkgs.system}.default.override {
    version = "0.23.1";
  };
  my-hermes-desktop = inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.desktop.override {
    version = "0.23.1";
    extraEnv = {
      HERMES_HOME = "${config.home.homeDirectory}/.hermes";
      HERMES_DOCKER_BINARY = "/run/current-system/sw/bin/podman";
    };
  };
in
{
  options = {
    my.llmclients = {
      enable = lib.mkEnableOption "Enable and configure llm clients";
      mcp.enable = lib.mkEnableOption "Enable mcp services" // {default = true;};
      hermes.enable = lib.mkEmableOption "Enable Hermes" // {default = true; };
      opencode.enable = lib.mkEnableOption "Enable and configure OpenCode" // {default = false;};
      claude.enable = lib.mkEnableOption "Enable Claude";
    };
  };
  imports = [ inputs.hermes-agent.homeManagerModules.default ];
  config = lib.mkIf config.my.llmclients.enable {
    home.packages = with pkgs;[
      unstable.codebase-memory-mcp
      unstable.cliproxyapi
      #my-hermes-desktop
      #claude-code
    ] ++ (if config.my.llmclients.opencode.enable then [unstable.opencode-desktop] else []);
    programs.hermes-agent = {
      enable = true;          # the hermes CLI on your PATH
      desktop.enable = true;  # the Electron application and a launcher
      desktop.package = my-hermes-desktop;
    };
    services.hermes-agent = {
      enable = true;
      package = my-hermes-agent;
      #gateway.enable = true;      # messaging platforms
      #backend.mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
      #backend.port = 9119;
      #settings.webapp = {
      #  enabled = true;
      #  host = "127.0.0.1";
      #  port = 9120;
      #};
      
    };
    programs.opencode = {
      enable = lib.mkIf config.my.llmclients.opencode.enable true;
      settings = {
        autoshare = false;
        autoupdate = false;
      };
      tools = {
        # https://opencode.ai/docs/tools/
      };
    };
    programs.mcp = {
      enable = lib.mkIf config.my.llmclients.mcp.enable true;
      servers = {
        codebase-memory = {
          enabled = true;
          command = "${lib.getExe unstable.codebase-memory-mcp}";
        };
      };
    };
    # services.ollama = {
    #   enable = true;
    #   acceleration = "rocm";
    # };
  };
}
