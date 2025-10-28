{
  pkgs,
  lib,
  config,
  unstable,
  ...
}:
{
  options = {
    my.git.enable = lib.mkEnableOption "Enable and configure git";
  };
  config = lib.mkIf config.my.git.enable {
    home.packages = with pkgs; [
      git-graph
      pre-commit
      unstable.gitleaks
      #earlybird
    ];
    programs.git = {
      enable = true;
      userName = "Frank Rosquin";
      userEmail = "frank.rosquin@gmail.com";
      difftastic = {
        enable = true;
        background = "dark";
        display = "inline";
        enableAsDifftool = true;
      };
      # hooks = {
      #   pre-commit = "${config.xdg.configHome}/git/hooks/local-pre-commit";
      # };
      # needs FIDO2 / yubikey5
      # signing = {
      #   format = "ssh";
      #   key = "";
      # };
      extraConfig = {
        init = {
          defaultBranch = "main";
          #templateDir = "${hooks}/share";
        };
        core = {
          hooksPath = "${config.xdg.configHome}/git/hooks";
        };
        push = {
          autoSetupRemote = true;
        };
        credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
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
    };
    xdg.configFile."git/hooks/pre-commit" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # TODO: https://warman.io/blog/2024/01/global-pre-commit/
        # https://pre-commit.com/#advanced
        set -euo pipefail

        # gitleaks
        # if ! ${lib.getExe pkgs.gitleaks} protect --staged --no-banner -v --redact
        echo "Running gitleaks pre-commit"
        if ! ${lib.getExe unstable.gitleaks} git --pre-commit --redact --staged --verbose
        then
          echo "gitleaks found secrets, not committing"
          exit 1
        fi

        if [ -e ./.pre-commit-config.yaml ]; then
          if command -v ${lib.getExe pkgs.pre-commit} > /dev/null; then
            exec ${lib.getExe pkgs.pre-commit}
          else
            echo '`pre-commit` not found.'
            exit 1
          fi
        fi

        # To prevent debug code from being accidentally committed, simply add a comment near your
        # debug code containing the keyword ! + nocommit and this script will abort the commit.
        NOCM="!"
        NOCM+="nocommit"
        if git commit -v --dry-run | grep $NOCM >/dev/null 2>&1
        then
          echo "Trying to commit non-committable code."
          echo "Remove the $NOCM string and try again."
          exit 1
        fi

        # Run local pre-commit hook if exists
        if [ -e ./.git/hooks/pre-commit ]; then
          ./.git/hooks/pre-commit "$@"
        else
          exit 0
        fi
      '';
    };
  };
}
