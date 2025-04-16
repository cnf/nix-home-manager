# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
{ lib
, buildGoModule
, fetchFromGitHub
, git
, ...
}:
buildGoModule rec {
  pname = "tailstrayer";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "cnf";
    repo = "tailscale-systray";
    rev = "098295b38458d2637b307dd1875b478ec9550601";
    hash = "sha256-tjQslHOLuX2QQ9OgPT5Hpllc+mgMBIKUBj/klIlzJys=";
  };

  vendorHash = "sha256-KpLW5NrQfobKL1xblkf4Fy499ClIQLVGtAHHU6c6/UI=";
  # nativeBuildInputs = [git];
  env.CGO_ENABLED = 0;

  preBuild= ''
    echo "creating .VERSION"
    echo ${version} > .VERSION
  '';
  postInstall = ''
    mv $out/bin/tailscale-systray $out/bin/${pname}
  '';


  meta = with lib; {
    description = "Tailscale Systray";
    # homepage = "";
    # license = licenses.mit;
    # maintainers = with maintainers; [  ];
  };
}
