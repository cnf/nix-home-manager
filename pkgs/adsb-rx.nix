{ 
  pkgs,
  lib
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "adsb-rx";
  version = "0.2.3";
  cargoLock.lockFile = ./Cargo.lock;
    src = lib.fetchFromGitHub {
    owner = "ktauchathuranga";
    repo = "adsb-rx";
    rev = "v${version}";
    hash = "";
  };
}
