{ pkgs, buildGoModule, lib, ... }:

buildGoModule rec {
  pname = "uv5r-ble-relay";
  version = "0.0-beta";

  src = pkgs.fetchFromGitHub {
    owner = "pcunning";
    repo = "uv5r-ble-relay";
    #rev = "v${version}";
    rev = "91c63dd7f95c85536a7d740f2f805eeac3edad18";
    hash = "sha256-+9gc4Vvxs4vEAM0FKHIW43oeWolrjBcsU0YdqqNHZxQ=";
  };

  vendorHash = "sha256-MCEXk2pCsyB0Iu0FBiaFH1WYOXP5s23pKqypGFp8/vg=";

  #nativeBuildInputs = [pkgs.musl];

  env.CGO_ENABLED = 0;

  ldflags = [
    #"-o uv5r-ble-relay cmd/uv5r-relay"

  #  "-s -w -X github.com/knqyf262/pet/cmd.version=${version}"
  #  "-linkmode external"
  #  "-extldflags '-static -L${musl}/lib'"
  ];
  postInstall = ''
    ls $out/bin
    #mv $out/main $out/bin/${pname}
  '';

  meta = with lib; {
    description = "Simple command-line snippet manager, written in Go";
    homepage = "https://github.com/knqyf263/pet";
    license = licenses.mit;
    maintainers = with maintainers; [ kalbasit ];
  };
}

