{ 
  pkgs,
  lib,
  fetchFromGitHub
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "adsb-rx";
  version = "0.2.3";
  #cargoLock.lockFile = ./Cargo.lock;
  src = fetchFromGitHub {
    owner = "ktauchathuranga";
    repo = "adsb-rx";
    rev = "v${version}";
    hash = "sha256-jt05i1wVd4UK3FqMm5b7zRzlFp2s0V3sZyrcxdDN5sc=";
  };
  
  cargoHash = "sha256-cFsoUuBF3DvcCdUN8vJaAMSexLdWOk4Wvq7V92YTJOc=";

  meta = with lib; {
    description = "ADSB RX";
    homepage = "https://github.com/ktauchathuranga/adsb-rx";
    changelog = "https://github.com/ktauchathuranga/adsb-rx/releases/tag/v${version}";
    #maintainers = with maintainers; [ majiir ];
  };
}
