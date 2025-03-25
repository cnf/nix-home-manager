{ pkgs, lib, config, unstable, ... }:
let
  synology-drive-pkg = unstable.synology-drive-client;
  #synology-drive-pkg = unstable.synology-drive-client.overrideAttrs (finalAttrs: prevAttrs: {
  #  buildInputs = prevAttrs.buildInputs ++ [unstable.libsForQt5.qt5.qtwayland];
  #  nativeBuildInputs = prevAttrs.nativeBuildInputs ++ [unstable.libsForQt5.qt5.qtwayland];
  #});

in
{
  options = { 
    my.synodrive.enable = lib.mkEnableOption "Install Synology Drive tools";
  };
  config = lib.mkIf config.my.synodrive.enable {
    home.packages = [
      synology-drive-pkg
    ];

    systemd.user.services.synology-drive = {
      Unit = {
        Description = "Synology Drive Client";
        After = [ "tray.target" ];
        Requires = [ "tray.target" ];
        PartOf = "graphical-session.target";
      };
      Service = {
        Environment = "QT_QPA_PLATFORM=''";
        ExecStart = "${lib.getExe unstable.synology-drive-client} start";
        ExecStop = "${lib.getExe unstable.synology-drive-client} stop";
        ExecReload = "${lib.getExe unstable.synology-drive-client} restart"; 
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
