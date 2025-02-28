{ pkgs, lib, config, ... }:
let
  hooks = pkgs.symlinkJoin {
    name = "git-scripts";
    paths = with pkgs; [
      (writeTextFile {
        name = "earlybird-hook";
        destination = "/share/hooks/earlybird-hook";
        executable = true;
        text = '' 
        #!/usr/bin/env bash

        echo "Running EarlyBird pre-commit hook"
        ${lib.getExe pkgs.earlybird} --fail-severity=high

        # $? stores exit value of the last command
        if [ $? -ne 0 ]; then
          echo "Secrets detection tests must pass before commit!"
          exit 1
        fi
      '';})
      earlybird
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/share/hooks/earlybird-hook --prefix PATH : $out/bin
    '';
  };
in
{
  options = {
    my.git.enable = lib.mkEnableOption "Enable and configure git";
  };
  config = lib.mkIf config.my.git.enable {
    home.packages = [
      pkgs.earlybird
    ];
    programs.git = {
    enable = true;
    userName = "Frank Rosquin";
    userEmail = "frank.rosquin@gmail.com";
    difftastic = {
      enable = true;
      display = "inline";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
        templateDir = "${hooks}/share";
      };
      #core.hooksPath = "${hooks}/share/hooks"; 
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
    };
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
