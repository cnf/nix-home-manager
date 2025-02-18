{ pkgs, lib, config, unstable, ... }:
{
  options = { 
    my.yubikey.enable = lib.mkEnableOption "Install yubikey tools";
  };
  config = lib.mkIf config.my.yubikey.enable {
    #programs.yubikey-touch-detector = {
    #  enable = true;
    #};
    home.packages = with pkgs; [
      yubioath-flutter
      yubico-piv-tool
      unstable.yubikey-touch-detector
    ];
    systemd.user.sockets.yubikey-touch-detector = {
      Unit.Description = "Unix socket activation for YubiKey touch detector service";
      Socket = {
        ListenStream = "%t/yubikey-touch-detector.socket";
        RemoveOnStop = true;
      };
      Install.WantedBy = [ "sockets.target" ];
    };

    systemd.user.services.yubikey-touch-detector = {
      Unit = {
        Description = "Detects when your YubiKey is waiting for a touch";
        Requires = "yubikey-touch-detector.socket";
      };
      Service = {
        ExecStart = "${lib.getExe unstable.yubikey-touch-detector} --libnotify";
        EnvironmentFile = "-%E/yubikey-touch-detector/service.conf";
        Environment="SSH_AUTH_SOCK=/run/user/%U/yubikey-agent/yubikey-agent.sock";
      };
      Install = {
        Also = "yubikey-touch-detector.socket";
        WantedBy = [ "default.target" ];
      };
    };
  };
}
