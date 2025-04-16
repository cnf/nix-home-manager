final: prev: 
{
  tio-new = prev.tio.overrideAttrs (old: new: rec {
    mesonFlags = [ "-Dbashcompletiondir=bash-completion/tio" ];
    version = "3.9";
    src = prev.fetchFromGitHub {
      owner = "tio";
      repo = "tio";
      rev = "v${version}";
      hash = "sha256-92+F41kDGKgzV0e7Z6xly1NRDm8Ayg9eqeKN+05B4ok=";
    };
  });
}
