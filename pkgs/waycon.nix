# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
{ lib
, buildGoModule
, fetchFromGitHub
, git
, ...
}:
buildGoModule rec {
  pname = "waycon";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "cnf";
    repo = "go-waycon";
    rev = "0d9cbe9e0c800247a2ffe4e7a574ffeb4bd5c2c3";
    hash = "sha256-R4KWxCB7bt/8pJ7rghv1EltGnng0nSnLFbbnNUtpkKs=";
  };

  vendorHash = null;
  # nativeBuildInputs = [git];
  env.CGO_ENABLED = 0;

  #preBuild= ''
  #  echo "creating .VERSION"
  #  echo ${version} > .VERSION
  #'';
  #postInstall = ''
  #  ls $out/bin
  #  #mv $out/main $out/bin/${pname}
  #'';


  meta = with lib; {
    description = "Waybar Connectivity indicator";
    homepage = "https://github.com/cnf/go-waycon";
    license = licenses.mit;
    maintainers = with maintainers; [ cnf ];
  };
}
