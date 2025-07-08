{ pkgs, unstable, lib, config, inputs, ... }:
let
  vscode-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};
  FHSPackagesList = (ps: with ps; [ 
    direnv
    python3
    zlib
    openssl.dev
    pkg-config
    cmake
  ]);
in
{
  options = { 
    my.vscode.enable = lib.mkEnableOption "Enable VSCode";
  };
  config = lib.mkIf config.my.vscode.enable {
    programs.vscode = {
      enable = true;
      package = unstable.vscode;
      #package = unstable.vscode.fhs;
      #package = unstable.vscode.fhsWithPackages FHSPackagesList;
      profiles.default.enableUpdateCheck = false;
      profiles.default.enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      profiles.default.extensions = with unstable.vscode-extensions; [
        #vscode-extensions.vscode-marketplace.continue.continue
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.isort
        vscode-extensions.vscode-marketplace.ms-python.autopep8
        vscode-extensions.vscode-marketplace.ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cpptools-extension-pack
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        ms-vscode.hexeditor
        #ms-vscode.vscode-serial-monitor
        ms-toolsai.datawrangler
        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-slideshow
        ms-vsliveshare.vsliveshare


        ms-vscode-remote.vscode-remote-extensionpack
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        vscode-extensions.vscode-marketplace.ms-vscode.remote-explorer
        vscode-extensions.vscode-marketplace.ms-vscode.remote-repositories
        vscode-extensions.vscode-marketplace.ms-vscode.remote-server
        #ms-vscode-remote.remote-wsl
        #ms-vscode.remote-explorer
        #ms-vscode.remote-repositories
        #ms-vscode.remote-server

        github.copilot-chat
        github.copilot

        #1Password.op-vscode
        #vscode-extensions.vscode-marketplace.cschlosser.doxdocgen
        vscode-extensions.vscode-marketplace.eamodio.gitlens
        vscode-extensions.vscode-marketplace.tailscale.vscode-tailscale
        vscode-extensions.vscode-marketplace.textualize.textual-syntax-highlighter
        editorconfig.editorconfig
        golang.go
        gruntfuggly.todo-tree
        mkhl.direnv
        streetsidesoftware.code-spell-checker
        #platformio.platformio-ide
        
        #ms-azuretools.vscode-docker
        #vscode-arduino.vscode-arduino-community

        arrterian.nix-env-selector
        jnoortheen.nix-ide

        timonwong.shellcheck
        #alexnesnes.teleplot

        #github.remotehub
        github.vscode-pull-request-github
        #randomfractalsinc.geo-data-viewer
        #marus25.cortex-debug
        #mcu-debug.memory-view
        #mcu-debug.peripheral-viewer
        #mcu-debug.rtos-views
      ];# ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        #{
        #  arch = "linux-x64";
        #  name = "continue";
        #  publisher = "Continue";
        #  #version = "1.0.1";
        #  #hash = "sha256-yDcrPpyEjL02/PtktG3XiYN0ZdWhB7AZZ3Mq9UOGZII=";
        #  version = "0.8.54";
        #  hash = "sha256-+/0ZQkRS6AD8u5+t2hiPwQxzwhEc+n2F0GVk1s0n74U=";
        #}
        #{
        #  name = "remote-explorer";
        #  publisher = "ms-vscode";
        #  version = "0.4.3";
        #  sha256 = "sha256-772l0EnAWXLg53TxPZf93js/W49uozwdslmzNwD1vIk=";
        #}
        #{
        #  name = "remote-repositories";
        #  publisher = "ms-vscode";
        #  version = "0.42.0";
        #  sha256 = "sha256-cYbkCcNsoTO6E5befw/ZN3yTW262APTCxyCJ/3z84dc=";
        #}
        #{
        #  name = "remote-server";
        #  publisher = "ms-vscode";
        #  version = "1.5.2";
        #  sha256 = "sha256-Gqb3/fSQS3rYheoFS8ksoidaZrOldxeYPoFSlzSgmVI=";
        #}
        #{
        #  name = "python";
        #  publisher = "ms-python";
        #  version = "2025.1.2025021102";
        #  #version = "2025.1.2025021701";
        #  hash = "sha256-qXQrBEKzZthZu1fdnRJXjryyHjpcxJA4c5LrhOI3deM=";
        #  #hash = "sha256-HzVN4wsuevRCbLkDKTg3SfgVhYcrmxThOQU63IiLV9I=";
        #  #hash = "sha256-6fDqQ587Wvvs3kLg41TIQZRjBoD00riql55viG3ZmNE=";
        #}
      #];
      ## the [section] parts are for overriding global defaults with language specifics
      profiles.default.userSettings = {
        "chat.commandCenter.enabled" = true;
        "window.menuBarVisibility" = "toggle";
        "editor.minimap.enabled" = false;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.tabSize" = 2;
        "editor.suggest.showStatusBar" = true;
        "editor.formatOnSaveMode" = "modificationsIfAvailable";
        "editor.wordWrap"= "wordWrapColumn";
        "editor.wordWrapColumn" = 120;
        "editor.fontFamily" = "'SauceCodePro Nerd Font', 'Source Code Pro', 'FontAwesome', Consolas, 'Courier New', monospace";
        "editor.guides.bracketPairs" = true;
        "editor.guides.highlightActiveIndentation" = true;
        "diffEditor.experimental.showMoves" = true;
        "diffEditor.experimental.useTrueInlineView" = true;
        "diffEditor.hideUnchangedRegions.enabled" = false;
        "diffEditor.renderSideBySide" = false;
        "diffEditor.ignoreTrimWhitespace"= false;
        "terminal.integrated.scrollback" = 50000;

        "debug.toolBarLocation" = "docked";
        "problems.showCurrentInStatus" = false;
        "liveshare.launcherClient" = "visualStudioCode";
        "workbench.secondarySideBar.showLabels" = false;

        # Languages
        # C++
        "C_Cpp.clang_format_fallbackStyle" = "{ BasedOnStyle: LLVM, ColumnLimit: 120 }";
        "C_Cpp.doxygen.generatedStyle" = "///";
        "[cpp]" = {
          "editor.defaultFormatter" = "ms-vscode.cpptools";
        };
        "[c]" = {
          "editor.defaultFormatter" = "ms-vscode.cpptools";
        };
        # Go
        #"go.gopath" = "${config.home.homeDirectory}/${config.programs.go.goPath}";
        #"go.toolsGopath" = "${config.xdg.dataHome}/vscode-tools/go";
        # Python
        "[python]" = {
          "editor.defaultFormatter" = "ms-python.black-formatter";
          "editor.formatOnType" = true;
        };
        "python.analysis.inlayHints.functionReturnTypes"= true;
        "python.analysis.typeCheckingMode" = "standard";
        "python.terminal.shellIntegration.enabled" = true;
        "python.testing.pytestEnabled" = true;
        "python.testing.unittestEnabled" = true;
        # CSS
        "css.customData" = [
          "${config.home.homeDirectory}/.vscode/custom/gtk.css-data.json"
        ];
        "css.lint.float" = "warning";
        "css.format.spaceAroundSelectorSeparator" = true;
        ## ToDo Tree
        #"todo-tree.general.statusBar" = "current file";
        "todo-tree.general.showActivityBarBadge" = true;
        "todo-tree.highlights.useColourScheme" = true;
        "todo-tree.general.schemes" = [
          "file"
          "ssh"
          "untitled"
          "vscode-notebook-cell"
          "output"
        ];
        "direnv.path.executable" = "${config.home.homeDirectory}/.nix-profile/bin/direnv";
        "direnv.restart.automatic" = true;
        "remote.autoForwardPortsSource"= "hybrid";
        ## cSpell
        #"cSpell.userWords" = [
        #  "nixpkgs"
        #  "nixd"
        #  "nixfmt"
        #  "rosquin"
        #];
        "cSpell.allowCompoundWords" = true;
        "cSpell.customDictionaries" = {
          words = {
            name = "additional-words";
            description = "Additional Words from home-manager";
            path = "~/.config/cspell/words.txt";
            scope = "user";
            addWords = false;
          };
          local = {
            name = "local-list";
            description = "Local Word List";
            path = "~/.config/cspell/local.txt";
            scope = "user";
            addWords = true;
          };
        };
        #"cSpell.dictionaries" = [
        #  "additional-words"
        #  "local-list"
        #];
        "idf.saveScope" = 2;
        "idf.hasWalkthroughBeenShown" = true;
        "dev.containers.defaultExtensions" = [
          "streetsidesoftware.code-spell-checker"
          "eamodio.gitlens"
          "GitHub.vscode-pull-request-github"
	  "gruntfuggly.todo-tree"
          "ms-vsliveshare.vsliveshare"
          "EditorConfig.EditorConfig"
          "timonwong.shellcheck"
        ];
        "dev.containers.dockerPath" = "podman";
        "dev.containers.dockerSocketPath" = "/run/user/1000/podman/podman.sock";
        "dev.containers.dockerComposePath" = "podman-compose";
        #"docker.dockerPath" = "/run/current-system/sw/bin/podman";
        #"docker.composeCommand" = "podman-compose";
        #"docker.environment" = {
        #  "DOCKER_HOST" = "unix:///run/user/1000/podman/podman.sock";
        #};

        ## Nix and NixOS
        "[nix]" = {"editor.defaultFormatter" = "jnoortheen.nix-ide";};
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "nixfmt";
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            # "nixpkgs" = {
            #   "expr" = "import (builtins.getFlake \"${workspaceFolder}\").inputs.nixpkgs { }";
            #   "expr" = "import <nixpkgs> {}"
            # };
            "formatting" = {
              "command" = [
                "nixfmt"
              ];
            };
            "options" = {
              #    "nixos" = {
              #      "expr" = "(builtins.getFlake \"/PATH/TO/FLAKE\").nixosConfigurations.CONFIGNAME.options"
              #    };
              "home_manager" = {
                "expr" = "(builtins.getFlake \\\"\${workspaceFolder}\\\").homeConfigurations.\"cnf@hydra\".options";
              };
              "unstable" = {
                "expr" = "(builtins.getFlake \\\"\${workspaceFolder}\\\").inputs.nixpkgs-unstable";
              };
              # "flake-parts" = {
              #   "expr" = "(builtins.getFlake \"${workspaceFolder}\").currentSystem.options"
              # };
            };
          };
        };

        ## doxyGen
        #"doxdocgen.generic.authorName" = "";
        #"doxdocgen.generic.authorEmail" = "";
        "doxdocgen.generic.useGitUserEmail" = true;
        "doxdocgen.generic.useGitUserName" = true;
        "doxdocgen.c.commentPrefix" = "///";
	"doxdocgen.c.firstLine" = "///";
	"doxdocgen.c.lastLine" = "";
	"doxdocgen.c.triggerSequence" = "///";

        ## Git Lens
        "gitlens.graph.allowMultiple" = true;
        "gitlens.graph.avatars" = true;
        "gitlens.graph.highlightRowsOnRefHover" = true;
        "gitlens.graph.layout" = "editor";
        "gitlens.graph.minimap.enabled" = false;
        "gitlens.graph.pullRequests.enabled" = true;
        "gitlens.graph.scrollMarkers.enabled" = true;
        "gitlens.graph.showDetailsView" = "open";
        "gitlens.graph.showGhostRefsOnRowHover" = true;
        "gitlens.graph.showUpstreamStatus" = true;
        "gitlens.graph.statusBar.enabled" = true;
        #"gitlens.graph.scrollMarkers.additionalTypes" = [];
        "gitlens.launchpad.indicator.enabled" = true;
        "gitlens.launchpad.indicator.polling.enabled" = false;
        "gitlens.plusFeatures.enabled" = true;
        "gitlens.telemetry.enabled" = false;
        "gitlens.views.worktrees.avatars" = true;
        "gitlens.views.worktrees.pullRequests.enabled" = true;
        "gitlens.views.worktrees.pullRequests.showForBranches" = true;
        "gitlens.views.worktrees.pullRequests.showForCommits" = true;
        "gitlens.views.worktrees.reveal" = true;
        "gitlens.views.worktrees.showBranchComparison" = "branch";
        "gitlens.worktrees.promptForLocation" = true;
      };
    };
    xdg.configFile."cspell/words.txt".text = ''
      # https://cspell.org/docs/dictionaries/custom-dictionaries for syntax
      # Created by home-manager, do not edit manually.
      # use local.txt to manually add words.
      nixos
      nixpkgs
      nixd
      nixfmt
      rosquin
      inmanta
      # Python
      py*
      # platformio, esp-idf, etc
      espressif
    '';
    #home.packages = with pkgs; [
      # nixd # in devel/default.nix
      # nixfmt # in devel/default.nix
      # nixpkgs-fmt
      #gcc
      #rnix-lsp
      #clang
      #direnv
      #python3
    #];
  };
}
