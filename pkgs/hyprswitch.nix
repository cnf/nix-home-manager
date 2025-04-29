{ pkgs, ... }:
with pkgs; 
  rustPlatform.buildRustPackage rec {
    pname = "hyprshell";
    version = "alpha";

    src = fetchFromGitHub {
      owner = "H3rmt";
      repo = "hyprswitch";
      rev = "c911a078e40655fd869df317479a6a93cce508b2";
      sha256 = "sha256-lc7WHG2/4bvOf6usBF6Ecj8sGeVj9gMWHEyNl5Ysm5w=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-bKFteBk/HZ5k1XKccpHyBGbdNd87s8QenG2UXsGCUOo=";
    patches = [
      (substituteAll {
        src = ./socat.patch;
        inherit socat;
      })
    ];

    nativeBuildInputs = [wrapGAppsHook4 pkg-config];
    buildInputs = [gtk4-layer-shell];
  }
