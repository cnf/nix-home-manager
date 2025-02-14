{ pkgs, lib, config, inputs, ... }:

{
  options = {
    my.git.enable = lib.mkEnableOption "Enable and configure git";
  };
  config = lib.mkIf config.my.git.enable {
    programs.git = {
    enable = true;
    userName = "Frank Rosquin";
    userEmail = "frank.rosquin@gmail.com";
    ignores = [
      "### Local testing trash"
      "*-OLD"
      "*-ORIG"
      "*-TEST"
      "bucket/"
      "my_*"
      "MY_*"
      "### Archives"
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"
      "### Logs and dbases"
      "*.log"
      "*.sqlite"
      "## Directories potentially created on remote AFP share"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
      "### Vim"
      "*.swp"
      "### Direnv"
      ".envrc" 
      "### Python"
      "__pycache__/"
    ];
    #extraConfig = {
    #  core = {
    #    excludesfile = "${config.home.homeDirectory}/.config/git/ignore";
    #  };
    #};
  };
};
}
