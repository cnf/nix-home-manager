{}:

{
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
      "### OS generated files"
      ".DS_Store"
      ".DS_Store?"
      "._*"
      "ehthumbs.db"
      "Thumbs.db"
      ".AppleDouble"
      ".LSOverride"
      "## Files that might appear in the root of a volume"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      "## Directories potentially created on remote AFP share"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
      "### Vim"
      "*.swp"
      "### Nix"
      "default.nix"
      "shell.nix"
      "### Direnv"
      ".envrc" 
    ];
    #extraConfig = {
    #  core = {
    #    excludesfile = "${config.home.homeDirectory}/.config/git/ignore";
    #  };
    #};
  };
}
